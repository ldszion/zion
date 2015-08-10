class ConfirmationController < ApplicationController
  before_action :authenticate_user, :must_have_person_if_logged_in, :must_be_active

  def index
  end
end
