class DoorkeeperApi < EventApi
  # 本来は1秒以上にすべきだが、Herokuの30秒タイムアウトルールをオーバーする可能性があるのでそれより短くする
  FETCH_SLEEP_SEC = 0.5

  # Override
  def fetch_event_details(event_url)
    event_info = fetch_event_info(event_url)
    attendees = fetch_attendees(event_url) if event_info["status"] == :ok
    if attendees.present?
      event_info["event"]["participant_profiles"] = attendees
      event_info
    else
      { 'status' => :not_found }
    end
  end

  private

  def fetch_event_info(event_url)
    event_id = event_url[/(?<=events\/)\d+/]
    url = "http://api.doorkeeper.jp/events/#{event_id}"
    logger.info "[INFO] Reading #{url}"
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    case response.code
      when '200'
        { 'status' => :ok, 'event' => JSON.parse(response.body)['event'] }
      when '404'
        { 'status' => :not_found }
      else
        raise "Could not get event details: #{response.inspect}"
    end
  end

  def fetch_attendees(event_url)
    if event_doc = read_doc_from_url(File.join(event_url.gsub(/^http:/, 'https:'), 'participants'))
      event_doc.xpath('//div[@class="member-list-item"]').map do |member_item|
        # "アカウント非公開の参加者" は、アンカータグになっていないので情報を取得できない
        if member_anchor = member_item.xpath('a').first
          name = member_anchor.xpath('div[@class="member-body"]/div[@class="member-name"]/span').text
          social_links = fetch_social_links(member_anchor.attributes['href'].value)
          { "name" => name }.merge(extract_accounts(social_links))
        end
      end.compact
    end
  end

  def fetch_social_links(member_url)
    sleep FETCH_SLEEP_SEC
    member_doc = read_doc_from_url(member_url)
    member_doc.xpath('//div[@class="social-links"]/a').map{ |a| a['href'] }
  end

  def extract_accounts(social_links)
    array = social_links.map do |link|
      case link
        when /facebook/
          ["facebook", link[/(?<=facebook.com\/)[^\/]+/]]
        when /twitter/
          ["twitter", link[/(?<=twitter.com\/)[^\/]+/]]
        when /github/
          ["github", link[/(?<=github.com\/)[^\/]+/]]
        else
          nil
      end
    end
    { "facebook" => nil, "twitter" => nil, "github" => nil}.merge(array.compact.to_h)
  end

  def read_doc_from_url(url)
    logger.info "[INFO] Reading #{url}"
    html = open(url)
    Nokogiri::HTML.parse(html, nil)
  rescue OpenURI::HTTPError => e
    e.io.status.first =~ /^4\d\d$/ ? nil : raise
  end
end
