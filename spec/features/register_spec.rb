require 'rails_helper'
require 'test_helper'

feature 'registration process' do
  EMAIL = 'register@test.com'
  PASSWORD = '123456'
  PASSWORD_CONFIRMATION = '123456'
  # Fill in all fields by default or by params
  def fill_in_fields(
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

  # Click register Button
  def click_register_button
    click_button 'Cadastrar'
  end

  before(:each) do
    visit register_url
    expect(page).to have_text 'Cadastro'
  end

  scenario 'registering with success' do
    fill_in_fields
    click_register_button
    expect(page).to have_text 'register@test.com'
  end

  scenario 'registering without password should not pass' do
    fill_in_fields EMAIL, '', ''
    click_register_button
    expect(page).to_not have_text EMAIL
    expect(page).to have_text 'Senha obrigatória'
  end

  scenario 'registering without password confirmation should not pass' do
    fill_in_fields EMAIL, PASSWORD, ''
    click_register_button
    expect(page).to_not have_text EMAIL
    expect(page).to have_text 'Confirmação de senha não bate com a senha informada'
  end
end
