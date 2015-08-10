require 'rails_helper'
require 'test_helper'

feature 'registration process' do
  before(:each) do
    visit new_user_url
    expect(page).to have_text 'Cadastro'
  end

  scenario 'registering without password should not pass' do
    fill_in_user_fields(EMAIL, '', '')
    click_register_button
    expect(page).to_not have_text EMAIL
    expect(page).to have_text 'Senha não pode ficar em branco'
  end

  scenario 'registering without password confirmation should not pass' do
    fill_in_user_fields(EMAIL, PASSWORD, '')
    click_register_button
    expect(page).to_not have_text EMAIL
    expect(page).to have_text 'Confirmação de senha não é igual a Senha'
  end

  context 'user registration process' do
    scenario 'beeing regular user' do
      register_with_success
      visit root_url
      expect(page).to have_text('Por favor, complete seu cadastro.')
    end

    scenario 'registering choosing option leader' do
      register_with_success(true)
      visit root_url
      expect(page).to have_text('Por favor, complete seu cadastro.')
    end
  end

  context 'account registration process' do
    scenario 'register without filling any fields should not pass' do
      register_with_success
      click_button 'Salvar'
      expect(page).to have_text('7 erros ocorreram')
    end

    scenario 'register only required fields should pass' do
      register_with_success
      fill_in_account_fields
      click_button 'Salvar'
      expect(page).to have_text(I18n.t('text.thanks.to_complete_account'))
      expect(page).to have_selector('#user-profile-header')
    end
  end

  def click_register_button
    click_button 'Cadastrar'
  end

  # Register with success
  def register_with_success(leader = false)
    if leader
      fill_in_user_fields(EMAIL, PASSWORD, PASSWORD_CONFIRMATION, leader)
    else
      fill_in_user_fields
    end
    click_register_button
    expect(page).to have_text 'register@test.com'
  end

  EMAIL = 'register@test.com'
  PASSWORD = '123456'
  PASSWORD_CONFIRMATION = '123456'

  # Fill in all fields by default or by params
  def fill_in_user_fields(email = EMAIL, password = PASSWORD,
    password_confirmation = PASSWORD_CONFIRMATION, leader = false)
    within '.form' do
      fill_in 'user_email', with: email
      fill_in 'user_password', with: password
      fill_in 'user_password_confirmation', with: password_confirmation
      select 'Ala #2', from: 'user_ward_id', visible: false
      if leader
        check 'user_leader'
        select 'Bispado', from: 'user_profile'
      end
    end
  end

  def fill_in_account_fields
    fill_in 'account_name', with: 'Nome'
    fill_in 'account_last_name', with: 'Ultimo Nome'
    fill_in 'account_nickname', with: 'Apelido'
    fill_in 'account_birthday', with: '10/10/1010'
    fill_in 'account_phone', with: '(61) 1111-2222'
    fill_in 'account_address', with: 'Meu endereço'
    select 'Masculino', from: 'account_gender'
    attach_file 'avatar_image', "#{Rails.root}/app/assets/images/perfil.jpg"
    fill_in 'account_emergency_contact_attributes_name', with: 'Nome de emergencia'
    fill_in 'account_emergency_contact_attributes_phone', with: '(61) 1111-2222'
    select 'Outro', from: 'account_emergency_contact_attributes_kinship'
  end
end
