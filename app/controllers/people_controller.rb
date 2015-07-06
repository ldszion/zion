class PeopleController < ApplicationController
  # Show a list of people
  def index
    @people = Person.all
  end
end
