class PeopleController < ApplicationController
  before_action :must_have_person_if_logged_in, except: [:new, :create]
  before_action :prepare_person, only: [:new, :create]
  # Show a list of people
  def index
    @people = Person.all
  end

  # Show the form to insert a new person
  def new
  end

  def create
    @person.phones.clear
    @person.assign_attributes person_params

    unless @person.valid?
      render :new and return
    end

    if @person.save
      current_user.person = @person
      current_user.save
      return redirect_to root_url, notice: t('text.thanks.to_complete_account')
    end
    render json: @person
  end

  private

  def prepare_person
    # The person to be inserted into current user
    @person = Person.new
    @person.phones.build
    @person.avatar = Picture.new
    @person.emergency_contact = EmergencyContact.new
    @wards = Ward.all.order(:name)
  end

  def person_params
    params.require(:person).permit(
      :name,
      :last_name,
      :nickname,
      :birthday,
      :address,
      :gender,
      :ward_id,
      :member,
      avatar_attributes: [
        :image
      ],
      emergency_contact_attributes: [
        :name,
        :phone,
        :kinship
      ],
      phones_attributes: [
        :number,
        :provider
      ],
    )
  end
end
