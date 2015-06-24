class SessionController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url and return
    end
    redirect_to login_url, notice: "Usuário ou senha inválidos"
  end

  def destroy
    if current_user
      session[:user_id] = nil
    end
    redirect_to login_url
  end
end
