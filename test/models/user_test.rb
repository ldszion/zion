require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new email: "valid@email.com"
    @user.password = "123456"
    @user.password_confirmation = "123456"
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "user with invalid email should be invalid" do
    @user.email = "invalidemail"
    assert_not @user.valid?
  end

  test "user without email sould not be saved" do
    @user.email = nil
    assert_not @user.save
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
end
