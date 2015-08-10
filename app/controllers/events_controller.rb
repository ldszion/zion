class EventsController < ApplicationController
  before_action :authenticate_user, :must_have_person_if_logged_in, :must_be_active

  def index
    @events = Event.all.order(:name)
  end

  def show
  end
end
