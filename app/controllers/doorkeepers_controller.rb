class DoorkeepersController < ApplicationController
  def fetch
    result = api_factory.fetch_event_details_with_attendee_user_ids(params[:event_url])
    status_table = { 'success' => :ok, 'not_found' => :not_found }
    render json: result, status: status_table.fetch(result[:status], :internal_server_error)
  end

  def api_factory
    case params[:event_url]
      when /doorkeeper/
        DoorkeeperApi
      when /connpass/
        ConnpassApi
      else
        raise "Unknown type: #{params[:event_url]}"
    end
  end
end