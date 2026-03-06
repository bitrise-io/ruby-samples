require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(name: "Alice", email: "alice@example.com", age: 30)
  end

  test "GET /users returns all users" do
    get users_url
    assert_response :ok
    assert_equal 1, JSON.parse(response.body).size
  end

  test "GET /users/:id returns the user" do
    get user_url(@user)
    assert_response :ok
    assert_equal @user.id, JSON.parse(response.body)["id"]
  end

  test "GET /users/:id returns 404 for unknown user" do
    get user_url(id: 0)
    assert_response :not_found
  end

  test "POST /users creates a user" do
    assert_difference("User.count") do
      post users_url, params: { user: { name: "Bob", email: "bob@example.com", age: 25 } }, as: :json
    end
    assert_response :created
  end

  test "POST /users returns 422 with invalid params" do
    post users_url, params: { user: { name: "", email: "bad", age: -1 } }, as: :json
    assert_response :unprocessable_entity
    assert JSON.parse(response.body)["errors"].present?
  end

  test "PATCH /users/:id updates the user" do
    patch user_url(@user), params: { user: { name: "Updated" } }, as: :json
    assert_response :ok
    assert_equal "Updated", JSON.parse(response.body)["name"]
  end

  test "DELETE /users/:id deletes the user" do
    assert_difference("User.count", -1) do
      delete user_url(@user)
    end
    assert_response :no_content
  end
end
