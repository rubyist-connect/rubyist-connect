require 'open-uri'
require 'nokogiri'
require 'hashie'

module DoorkeeperApi
  class << self
    def fetch_event_details_with_attendee_user_ids(event_url)
      result = fetch_event_details_as_mash(event_url)
      if result.status == 'success'
        event = result.event
        { status: result.status, name: event.title, attendee_user_ids: _attendee_user_ids(event.participant_profiles) }.tap do |info|
          _logger.info "[INFO] Event details: #{info.inspect}, #{event_url}"
        end
      else
        _logger.info "[INFO] Event not found: #{event_url}"
        { status: result.status }
      end
    end

    def fetch_event_details_as_mash(event_url)
      Hashie::Mash.new(fetch_event_details(event_url))
    end

    def fetch_event_details(event_url)
      event_info = _fetch_event_info(event_url)
      attendees = _fetch_attendees(event_url) if event_info.present?
      if [event_info, attendees].all?(&:present?)
        event_info["status"] = 'success'
        event_info["event"]["participant_profiles"] = attendees
        event_info
      else
        { 'status' => 'not_found' }
      end
    rescue => e
      _logger.error "[ERROR] #{e.inspect}"
      _logger.error e.backtrace.join("\n")
      { 'status' => "ERROR: #{e.message}" }
    end

    # 以下はprivateなクラスメソッド（メソッド名はアンダースコアで始める）

    def _fetch_event_info(event_url)
      event_id = event_url[/(?<=events\/)\d+/]
      url = "http://api.doorkeeper.jp/events/#{event_id}"
      _logger.info "[INFO] Reading #{url}"
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

    def _attendee_user_ids(participant_profiles)
      participant_profiles.map { |profile|
        _find_user_by_profile(profile).try(:id)
      }.compact
    end

    def _find_user_by_profile(profile)
      condition = <<-SQL
(LOWER(nickname) = :github)
OR (LOWER(twitter_name) = :twitter)
OR (LOWER(facebook_name) = :facebook)
OR (REPLACE(LOWER(name), ' ', '') = :name)
OR (REPLACE(LOWER(nickname), ' ', '') = :nickname)
      SQL

      users = User.active.where(condition,
                        github: profile.github.try(:downcase),
                        twitter: profile.twitter.try(:downcase),
                        facebook: profile.facebook.try(:downcase),
                        name: profile.name.gsub(' ', '').downcase,
                        nickname: profile.name.gsub(' ', '').downcase
      )
      if users.count > 1
        _logger.warn "[WARN] Found more than one users: #{users.inspect}"
        nil
      else
        users.first
      end
    end

    def _fetch_attendees(event_url)
      if doc = _read_doc_from_url(event_url)
        doc.xpath('//div[@class="user-profile-details"]').map do |profile|
          name = profile.xpath('div[@class="user-name"]').text
          social_links = profile.xpath('div[@class="user-social"]').xpath('a').map{|a| a['href']}
          { "name" => name }.merge(_extract_accounts(social_links))
        end
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
    rescue OpenURI::HTTPError => e
      e.io.status.first =~ /^4\d\d$/ ? nil : raise
    end

    def _logger
      Rails.logger
    end
  end
end