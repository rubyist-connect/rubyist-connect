class DoorkeepersController < ApplicationController
  def fetch
    result = DoorkeeperApi.fetch_event_details_as_mash(params[:event_url])
    event = result.event
    render json: { name: event.title, attendee_user_ids: attendee_user_ids(event.participant_profiles) }
  end

  private

  def attendee_user_ids(participant_profiles)
    participant_profiles.map { |profile|
      user_id = nil
      if github = profile.github
        user_id = User.find_by_nickname(github).try(:id)
      end
      if user_id.nil? && (twitter = profile.twitter)
        user_id = User.find_by_twitter_name(twitter).try(:id)
      end
      user_id
    }.compact
  end
end