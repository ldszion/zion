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
    @wards = Ward.all.order(:name)
  end

  # Add user to database and signin
  def signup
    render json: person_params and return
    person = Person.new person_params
    person.phones.build number: params[:phone]
    render json: person.phones
  end

  # Permit some user's fields from params
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  # Permit some person's fields from params
  def person_params
    params.require(:person).permit(
      # :avatar,
      :name,
      :nickname,
      :birthday,
      :phones,
      :ward_id,
      :gender,
      :agreed
    )
  end
end
