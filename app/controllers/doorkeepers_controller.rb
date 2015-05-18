class DoorkeepersController < ApplicationController
  def fetch
    result = DoorkeeperApi.fetch_event_details_with_attendee_user_ids(params[:event_url])
    status_table = { 'success' => :ok, 'not_found' => :not_found }
    render json: result, status: status_table.fetch(result[:status], :internal_server_error)
  end
end