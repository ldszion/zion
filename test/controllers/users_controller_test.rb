require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    log_in_as_admin
    @user = users(:one)
    @user.password = "123456"
    @user.password_confirmation = "123456"
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_redirected_to register_url
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: {
        email: 'newuser@mail.com',
        password: '123456',
        password_confirmation: '123456'
      }
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    patch :update, id: @user, user: { email: @user.email, password: @user.password }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end
