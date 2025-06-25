require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_user_registration_path
    assert_response :success
  end

  test "should create user" do
    post user_registration_path, params: { user: { email: "test@example.com", password: "password123", password_confirmation: "password123" } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    # Optional: assert user count increased or session signed in
  end
end
