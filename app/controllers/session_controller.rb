class SessionController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url and return
    end
    redirect_to login_url, notice: "Usuário ou senha inválidos"
  end

  def destroy
    if current_user
      session.delete[:user_id]
    end
    redirect_to login_url
  end
end
