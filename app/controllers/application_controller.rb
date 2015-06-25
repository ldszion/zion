class ApplicationController < ActionController::Base
  include SessionHelper
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
end
