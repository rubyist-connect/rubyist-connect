require 'open-uri'
require 'nokogiri'
require 'hashie'

module DoorkeeperApi
  class << self
    def fetch_event_details_as_mash(event_url)
      Hashie::Mash.new(fetch_event_details(event_url))
    end

    def fetch_event_details(event_url)
      event_id = event_url[/(?<=events\/)\d+/]
      url = "http://api.doorkeeper.jp/events/#{event_id}"
      _logger.info "[INFO] Reading #{url}"
      uri = URI.parse(url)
      # TODO 404エラー等のエラー処理を考慮する
      response = Net::HTTP.get_response(uri)
      JSON.parse(response.body).tap do |event_details|
        event_details["status"] = 'success'
        event_details["event"].merge!("participant_profiles" => _fetch_attendees(event_url))
      end
    rescue OpenURI::HTTPError => e
      _logger.warn "[WARN] HTTPError: #{e}"
      case e.io.status.first
        when /^4\d\d$/
          { 'status' => 'not_found' }
        else
          raise
      end
    rescue => e
      _logger.error "[ERROR] #{e.inspect}"
      _logger.error e.backtrace.join("\n")
      { 'status' => "ERROR: #{e.message}" }
    end

    def _fetch_attendees(event_url)
      # TODO 404エラー等のエラー処理を考慮する
      doc = _read_doc_from_url(event_url)
      doc.xpath('//div[@class="user-profile-details"]').map do |profile|
        name = profile.xpath('div[@class="user-name"]').text
        social_links = profile.xpath('div[@class="user-social"]').xpath('a').map{|a| a['href']}
        { "name" => name }.merge(_extract_accounts(social_links))
      end
    end

    def _extract_accounts(social_links)
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

    def _read_doc_from_url(url)
      _logger.info "[INFO] Reading #{url}"
      html = open(url)
      Nokogiri::HTML.parse(html, nil)
    end

    def _logger
      Rails.logger
    end
  end
end