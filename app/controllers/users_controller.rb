class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user, except: [:new, :create]
  before_action :must_have_person_if_logged_in
  before_action :must_be_active, except: :show
  before_action :check_authorization, only: [:index]
  before_action :match_old_password, only: :change_password

  layout 'session', only: [:new]

  def index
    @users = User.all
  end

  def show
    @account = @user.account
    @events = Event.all.order(:name)
  end

  def new
    @user = User.new
    @wards = Ward.all.order(:name)
  end

  def create
    @user = User.new(user_params)
    @wards = Ward.all.order(:name)

    @user.active = true unless @user.leader?

    render(:new) && return unless @user.save

    log_in @user
    redirect_to new_account_url, notice: t('text.complete_account')
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # Action para alterar a senha. Se jah chegou nesse metodo eh porque a senha
  # digitada estah correta pois jah passou pelo filtro match_old_password
  def change_password
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = 'Senha alterada com sucesso'
    else
      flash[:errors] = @user.errors.full_messages
    end
    redirect_to edit_account_path @user.account
  end

  # Altera o perfil de um usuario via AJAX
  def change_profile
    # Altera o perfil somente se usuario logado for administrador e se o id de usuario nao for o do superadmin
    if current_user.admin? && params[:id] != 1
      user = User.find params[:id]
      user.profile = params[:profile]
      if user.save
        render json: :ok
      else
        render json: { message: 'Não foi possível alterar o perfil de usuário' }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html do
        redirect_to users_url,
                    notice: 'User was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  def activate
    if current_user.admin?
      set_user
      @user.active = true
      if @user.save
        notice = 'Usuário ativado com sucesso!'
      else
        notice = 'Usuário não pode ser ativado! Contate o administrador do sistema'
      end
      redirect_to users_url, notice: notice
    else
      redirect_to current_user, notice: 'Você não pode ativar um usuário!'
    end
  end

  def deactivate
    if current_user.admin?
      set_user
      @user.active = false
      if @user.save
        notice = 'Usuário desativado com sucesso!'
      else
        notice = 'Usuário não pode ser desativado! Contate o administrador do sistema'
      end
      redirect_to users_url, notice: notice
    else
      redirect_to current_user, notice: 'Você não pode desativar um usuário!'
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Permit some user's fields from params
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :ward_id, :profile, :leader)
  end

  # Redireciona para tela de conta se a senha digitada nao for igual a senha
  # antiga
  def match_old_password
    @old_password = params[:user][:old_password]
    unless current_user.authenticate(@old_password)
      redirect_to edit_account_path(current_user.account),
                  alert: 'A senha digitada está incorreta'
    end
  end

  # Verifica se usuario logado tem permissao para acessar a controller
  def check_authorization
    permitted = [:admin]
    fail User::NotAuthorized unless permitted.include? current_user.profile.to_sym
  end
end
