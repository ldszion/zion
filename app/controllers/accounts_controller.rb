class AccountsController < ApplicationController
  before_action :must_have_person_if_logged_in, except: [:new, :create]
  before_action :prepare_account, only: [:new, :create]
  # Show a list of people
  def index
    @accounts = Account.all
  end

  # Show the form to insert a new person
  def new
  end

  def edit
    @account = Account.find(params[:id])
  end

  def update
    @account = Account.find(params[:id])
    @account.assign_attributes account_params unless params[:account].nil?

    set_avatar_if_exists
    if @account.save
      redirect_to edit_account_path(@account),
                  notice: 'Dados atualizados com sucesso'
    else
      render :edit
    end
  end

  def create
    @account.assign_attributes account_params
    @account.avatar = set_avatar_if_exists || Picture.new

    if @account.save
      current_user.update account: @account
      return redirect_to user_path(@account.user),
                         notice: t('text.thanks.to_complete_account')
    else
      render :new
    end
  end

  private

  # Define o avatar da conta se usuario enviou algum avatar valido
  def set_avatar_if_exists
    @avatar = Picture.new
    @avatar.image = uploaded_image
    @account.avatar = @avatar if @avatar.valid?
  end

  # Retorna a imagem enviada pelo usuario se tiver alguma
  def uploaded_image
    params[:avatar][:image] unless params[:avatar].nil?
  end

  def prepare_account
    # The account to be inserted into current user
    @account = Account.new
    @avatar = Picture.new
    @account.avatar = @avatar
    @account.emergency_contact = EmergencyContact.new
  end

  def account_params
    params.require(:account).permit(
      :name, :last_name, :nickname, :birthday, :address, :gender, :member,
      :phone, emergency_contact_attributes: [:name, :phone, :kinship]
    ) unless params[:account].nil?
  end
end
