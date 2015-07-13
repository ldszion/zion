require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new email: "valid@email.com"
    @user.password = "123456"
    @user.password_confirmation = "123456"
    @user.profile = Profile.first
  end

  test "user should be valid" do
    assert @user.valid?, why_is_not_valid(@user)
  end

  test "user with invalid email should be invalid" do
    @user.email = "invalidemail"
    assert_not @user.valid?
  end

  test "user without email sould not be saved" do
    @user.email = nil
    assert_not @user.save
  end

  test "user with a taken email should not be valid" do
    user = users(:two)
    user.email = users(:one)
    assert_not user.save, "Email field should be unique"
  end

  test "user with password confirmation wrong should not be saved" do
    @user.password_confirmation = "different"
    assert_not @user.save
  end

  test "user without password should not be saved" do
    @user.password = nil
    @user.password_confirmation = nil
    assert_not @user.save
  end

  test "user without profile should not be valid" do
    @user.profile = nil
    assert_not @user.valid?, why_is_not_valid(@user)
  end
end
