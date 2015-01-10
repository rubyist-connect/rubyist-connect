class EventsController < ApplicationController
  def index
    @events = Event.includes(participations: [:user])
      .all.order(created_at: :asc)
  end
end
