require 'rails_helper'

feature 'authentication' do

  before(:all) do
    @user = User.new email: 'marcotulio.avila@gmail.com',
      password: '123456',
      password_confirmation: '123456'
    @user.save
  end

  scenario 'user signs in' do
    visit login_url

    fill_in 'email', with: @user.email
    fill_in 'password', with: @user.password

    click_button 'Entrar'

    expect(page).to have_text('ZION')
  end
end
