class SessionController < ApplicationController
  def new
    render "login"
  end

  def create
    user = User.find_by_email(params[:email])
    if user and user.authenticate(params[:password])
      log_in user
      redirect_to root_url and return
    end
    redirect_to login_url, notice: "Usuário ou senha inválidos"
  end

  def destroy
    if logged_in?
      logout
    end
    redirect_to login_url
  end

  # Show register form to guest
  def register
    @user = User.new
  end

  # Add user to database and signin
  def signup
    render json: params
  end
end
