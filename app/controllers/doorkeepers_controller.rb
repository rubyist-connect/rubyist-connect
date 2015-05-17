class DoorkeepersController < ApplicationController
  def fetch
    result = DoorkeeperApi.fetch_event_details_as_mash(params[:event_url])
    event = result.event
    render json: { name: event.title, attendee_user_ids: attendee_user_ids(event.participant_profiles) }
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
OR (LOWER(facebook_name) = :facebook)
OR (REPLACE(LOWER(name), ' ', '') = :name)
OR (REPLACE(LOWER(nickname), ' ', '') = :nickname)
    SQL

    User.where(condition,
               github: profile.github.try(:downcase),
               twitter: profile.twitter.try(:downcase),
               facebook: profile.facebook.try(:downcase),
               name: profile.name.gsub(' ', '').downcase,
               nickname: profile.name.gsub(' ', '').downcase
    ).first
  end
end