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
    @account.assign_attributes account_params
    if(@account.save)
      redirect_to current_user, notice: 'Dados atualizados com sucesso'
    else
      render :edit
    end
  end

  def create
    @account.assign_attributes account_params
    # @account.birthday = params[:account][:birthday].to_date

    if @account.save
      current_user.account = @account
      current_user.save
      return redirect_to user_path(@account.user), notice: t('text.thanks.to_complete_account')
    else
      render :new and return
    end
    render json: @account
  end

  private

  def prepare_account
    # The account to be inserted into current user
    @account = Account.new
    # @account.avatar = Picture.new
    @account.emergency_contact = EmergencyContact.new
  end

  def account_params
    params.require(:account).permit(
      :name,
      :last_name,
      :nickname,
      :birthday,
      :address,
      :gender,
      :member,
      :phone,
      # avatar_attributes: [
      #   :image
      # ],
      emergency_contact_attributes: [
        :name,
        :phone,
        :kinship
      ],
    )
  end
end
