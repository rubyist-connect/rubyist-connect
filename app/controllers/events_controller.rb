class EventsController < ApplicationController
  before_action :set_event, only: %i(show edit update destroy)
  before_action :set_users, only: %i(new edit create update)

  def index
    @events = Event.includes(participations: [:user])
      .all.order(created_at: :asc)
  end

  def new
    @event = Event.new
  end

  def show
  end

  def edit
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to @event, notice: 'Event was successfully created.'
    else
      render :new
    end
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: 'Event was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to events_path, notice: 'Event was successfully destroyed.'
  end

  private

  def event_params
    params.require(:event).permit(:name, user_ids: [])
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def set_users
    @users = User.all
  end
end
