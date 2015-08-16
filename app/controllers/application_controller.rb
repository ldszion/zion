class ApplicationController < ActionController::Base
  include SessionHelper
  include UsersHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  rescue_from User::NotAuthorized, with: :user_not_authorized

  # Redirects user to login page if user is not logged in
  def authenticate_user
    unless logged_in?
      redirect_to login_url, notice: "Favor entrar com um email e senha"
    end
  end

  # Redireciona usuario de volta se ele nao tem permissao para acessar a pagina
  def user_not_authorized
    render file: 'public/404.html', status: :not_found, layout: false
  end

  # Redirects logged-in user to add his personal informations in case its nil
  def must_have_person_if_logged_in
    if logged_in? and current_user.account.nil?
        redirect_to new_account_url, notice: "Por favor, complete seu cadastro."
    end
  end

  def must_be_active
    if logged_in? and !current_user.active?
      redirect_to current_user, notice: "Você não pode realizar qualquer outra ação enquanto não tiver seu perfil ativado. Contate um administrador!"
    end
  end
end
