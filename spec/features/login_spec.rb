require 'rails_helper'

feature 'authentication process' do
  given(:email) { 'admin@gmail.com' }
  given(:password) { '123456' }
  scenario 'signing in with correct credentials' do
    visit login_url
    within '.form.segment' do
      fill_in 'email', with: email
      fill_in 'password', with: password
    end
    click_button 'Entrar'
    expect(page).to have_text('ZION')
  end

  given(:wrong_user) { User.new email: 'unexistent@user.com', password: '123456' }
  scenario 'signing in with wrong credentials' do
    visit login_url
    within '.form.segment' do
      fill_in 'email', with: wrong_user.email
      fill_in 'password', with: wrong_user.password
    end
    click_button 'Entrar'
    expect(page).to have_text('Usuário ou senha inválidos')
  end
end
