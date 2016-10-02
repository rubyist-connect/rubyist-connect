class DoorkeeperApi < EventApi
  # Override
  def fetch_event_details(event_url)
    event_info = fetch_event_info(event_url)
    attendees = fetch_attendees(event_url) if event_info.present?
    if [event_info, attendees].all?(&:present?)
      event_info["status"] = 'success'
      event_info["event"]["participant_profiles"] = attendees
      event_info
    else
      { 'status' => 'not_found' }
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
        JSON.parse(response.body)
      when '404'
        nil
      else
        raise "Could not get event details: #{response.inspect}"
    end
  end

  def fetch_attendees(event_url)
    if doc = read_doc_from_url(File.join(event_url.gsub(/^http:/, 'https:'), 'participants'))
      doc.xpath('//div[@class="user-profile-details"]').map do |profile|
        name = profile.xpath('div[@class="user-name"]').text
        social_links = profile.xpath('div[@class="user-social"]').xpath('a').map{|a| a['href']}
        { "name" => name }.merge(extract_accounts(social_links))
      end
    end
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
