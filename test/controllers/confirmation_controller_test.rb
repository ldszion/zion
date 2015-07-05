require 'test_helper'

class ConfirmationControllerTest < ActionController::TestCase

  setup do
    log_in_as_admin
  end

  test "should get index" do
    get :index
    assert_response :success
  end

end
