class DoorkeepersController < ApplicationController
  def fetch
    result = DoorkeeperApi.fetch_event_details_as_mash(params[:event_url])
    event = result.event
    render json: { name: event.title }
  end
end