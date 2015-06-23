class EventsController < ApplicationController
  def index
    @events = Event.all.order(:name)
  end
  def show
  end
end
