require 'open-uri'
require 'nokogiri'
require 'hashie'

class EventApi
  def self.fetch_event_details_with_attendee_user_ids(event_url)
    api = api_factory(event_url)
    api.fetch_event_details_with_attendee_user_ids(event_url)
  end

  def self.api_factory(event_url)
    case event_url
      when /doorkeeper/
        DoorkeeperApi.new
      when /connpass/
        ConnpassApi.new
      else
        raise "Unknown type: #{event_url}"
    end
  end

  def fetch_event_details_with_attendee_user_ids(event_url)
    result = fetch_event_details_as_mash(event_url)
    if result.status == :ok
      event = result.event
      { status: result.status, name: event.title, attendee_user_ids: attendee_user_ids(event.participant_profiles) }.tap do |info|
        logger.info "[INFO] Fetch event successfully: #{info.inspect}, #{event_url}"
      end
    else
      logger.info "[INFO] Fetch event unsuccessfully: #{result.status}, #{event_url}"
      { status: result.status, message: result.message }
    end
  end

  def fetch_event_details_as_mash(event_url)
    begin
      hash = fetch_event_details(event_url)
    rescue => e
      logger.error "[ERROR] #{e.inspect}"
      logger.error e.backtrace.join("\n")
      hash = { 'status' => :internal_server_error, 'message' => e.message }
    end
    Hashie::Mash.new(hash)
  end

  # abstract
  def fetch_event_details(event_url)
    raise 'should implement this.'
  end

  private

  def attendee_user_ids(participant_profiles)
    participant_profiles.map { |profile|
      find_user_by_profile(profile).try(:id)
    }.compact
  end

  def find_user_by_profile(profile)
    condition = <<-SQL
(LOWER(nickname) = :github)
OR (LOWER(twitter_name) = :twitter)
OR (REPLACE(LOWER(name), ' ', '') = :name)
OR (REPLACE(LOWER(nickname), ' ', '') = :nickname)
    SQL

    users = User.active.where(condition,
                              github: profile.github.try(:downcase),
                              twitter: profile.twitter.try(:downcase),
                              name: profile.name.gsub(' ', '').downcase,
                              nickname: profile.name.gsub(' ', '').downcase
    )
    if users.count > 1
      logger.warn "[WARN] Found more than one users: #{users.inspect}"
      nil
    else
      users.first
    end
  end

  def logger
    Rails.logger
  end
end