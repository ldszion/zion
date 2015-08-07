class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user, except: [:new, :create]
  before_action :must_have_person_if_logged_in
  before_action :must_be_active, except: :show

  def index
    @users = User.all
  end

  def show
    @account = @user.account
  end

  def new
    @user = User.new
    @wards = Ward.all.order(:name)
  end

  def create
    @user = User.new(user_params)
    @wards = Ward.all.order(:name)

    if(!@user.leader?)
      @user.active = true
    end

    render(:new) && return unless @user.save

    log_in @user
    redirect_to users_url
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

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def activate
    if(current_user.admin?)
      set_user
      @user.active = true
      if(@user.save)
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
    if(current_user.admin?)
      set_user
      @user.active = false
      if(@user.save)
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
end
