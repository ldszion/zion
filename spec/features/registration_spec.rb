require 'rails_helper'
require 'test_helper'

feature 'registration process' do

  # ENTITIES FOR TESTS

  # This is a complete Emergency Contact
  emergency_contact = EmergencyContact.new name: 'Beltrano',
                                           phone: '(61) 1234-1234',
                                           kinship: Person::FATHER

  # This is a avatar
  avatar = Picture.new image: File.new("#{Rails.root}/app/assets/images/perfil.jpg")

  # This is a complete and correct person
  person = Person.new name: 'Fulano Maluco',
                      last_name: 'Silva',
                      nickname: 'Fulaninho',
                      birthday: '12/02/1987'.to_date,
                      address: 'Endereço qualquer',
                      gender: Person::MALE,
                      ward: Ward.first,
                      member: true,
                      phones: [Phone.new(number: '(61) 8555-7878')],
                      emergency_contact: emergency_contact,
                      avatar: avatar

  # Click register Button
  def click_register_button
    click_button 'Cadastrar'
  end

  # Register with success
  def register_with_success
    fill_in_user_fields
    click_register_button
    expect(page).to have_text 'register@test.com'
  end

  EMAIL = 'register@test.com'
  PASSWORD = '123456'
  PASSWORD_CONFIRMATION = '123456'
  # Fill in all fields by default or by params
  def fill_in_user_fields(
      email = EMAIL,
      password = PASSWORD,
      password_confirmation = PASSWORD_CONFIRMATION
  )
    within '.form' do
      fill_in 'user_email', with: email
      fill_in 'user_password', with: password
      fill_in 'user_password_confirmation', with: password_confirmation
    end
  end

  before(:each) do
    visit register_url
    expect(page).to have_text 'Cadastro'
  end

  scenario 'registering with success' do
    register_with_success
  end

  scenario 'registering without password should not pass' do
    fill_in_user_fields EMAIL, '', ''
    click_register_button
    expect(page).to_not have_text EMAIL
    expect(page).to have_text 'Senha não pode ficar em branco'
  end

  scenario 'registering without password confirmation should not pass' do
    fill_in_user_fields EMAIL, PASSWORD, ''
    click_register_button
    expect(page).to_not have_text EMAIL
    expect(page).to have_text 'Confirmação de senha não é igual a Senha'
  end

  context 'complete registration process' do
    before { register_with_success }
    scenario 'should see "Por favor, complete seu cadastro." message when registration is not completed' do
      visit root_url
      expect(page).to have_text('Por favor, complete seu cadastro.')
    end
  end
end
