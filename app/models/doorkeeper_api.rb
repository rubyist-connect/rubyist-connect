require 'open-uri'
require 'nokogiri'
require 'hashie'

class DoorkeeperApi
  def self.fetch_event_details_as_mash(event_id)
    Hashie::Mash.new(fetch_event_details(event_id))
  end

  def self.fetch_event_details(event_id)
    url = "http://api.doorkeeper.jp/events/#{event_id}"
    uri = URI.parse(url)
    # TODO 404エラー等のエラー処理を考慮する
    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body).tap do |event_details|
      event_details["event"].merge!("participant_profiles" => fetch_attendees(event_id))
    end
  end

  def self.fetch_attendees(event_id)
    url = "https://nishiwaki-koberb.doorkeeper.jp/events/#{event_id}"
    # TODO 404エラー等のエラー処理を考慮する
    doc = read_doc_from_url(url)
    doc.xpath('//div[@class="user-profile-details"]').map do |profile|
      name = profile.xpath('div[@class="user-name"]').text
      social_links = profile.xpath('div[@class="user-social"]').xpath('a').map{|a| a['href']}
      { "name" => name }.merge(extract_accounts(social_links))
    end
  end

  def self.extract_accounts(social_links)
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

  def self.read_doc_from_url(url)
    logger.info "[INFO] Reading #{url}"
    html = open(url)
    Nokogiri::HTML.parse(html, nil)
  end

  def self.logger
    Rails.logger
  end
end