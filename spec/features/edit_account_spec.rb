require 'rails_helper'
require 'test_helper'

describe AccountsController do
  include SessionHelper
  before(:each) do
    log_in User.first
    visit user_path(current_user)
  end

  scenario 'reaches edit page' do
    click_link 'edit'
    expect(:page).to have_text 'Editing user'
  end
end
