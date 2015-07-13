class ConfirmationController < ApplicationController
  before_action :authenticate_user, :must_have_person_if_logged_in

  def index
  end
end
