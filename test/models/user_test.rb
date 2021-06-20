require "test_helper"

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(name: "TestUser", email: "testuser@email.com", password: "password")
  end

  test "should make user" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = " "
    assert_not @user.valid?
  end
end
