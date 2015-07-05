require 'test_helper'

class EventsControllerTest < ActionController::TestCase

  setup do
    log_in_as_admin
  end

  test "should get show" do
    get :show, id: 1
    assert_response :success
  end

end
