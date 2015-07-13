class ApplicationController < ActionController::Base
  include SessionHelper
  include UsersHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  # Redirects user to login page if user is not logged in
  def authenticate_user
    if !logged_in?
      redirect_to login_url, notice: "Favor entrar com um email e senha"
    end
  end

  # Redirects logged-in user to add his personal informations in case its nil
  def must_have_person_if_logged_in
    if logged_in? and current_user.person.nil?
      redirect_to new_person_url, notice: "Por favor, complete seu cadastro."
    end
  end
end
