class SessionController < ApplicationController
  def new
    render 'login'
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      log_in user
      redirect_to(root_url) && return
    end
    redirect_to login_url, alert: 'Usuário ou senha inválidos'
  end

  def destroy
    logout if logged_in?
    redirect_to login_url
  end

  def home
    if current_user?
      redirect_to current_user
    else
      redirect_to login_url
    end
  end
end
