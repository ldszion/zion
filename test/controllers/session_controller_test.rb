require 'test_helper'

class SessionControllerTest < ActionController::TestCase

  setup do
    log_in_as_admin
    @user = users(:one)
    @user.password = "123456"
    @user.password_confirmation = "123456"
  end

  test "should go to login page" do
    get :new
    assert_response :success
  end

  test "should logout" do
    get :destroy
    assert_redirected_to login_url
  end

end
