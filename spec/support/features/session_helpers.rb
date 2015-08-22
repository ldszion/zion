module Features
  module SessionHelpers
    def login(email, password)
      visit login_url
      fill_in 'email', with: email
      fill_in 'password', with: password
      click_button 'Entrar'
    end
  end
end
