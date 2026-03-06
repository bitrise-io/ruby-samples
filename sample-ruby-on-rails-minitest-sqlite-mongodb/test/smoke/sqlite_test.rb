require "test_helper"

class SqliteConnectivityTest < ActiveSupport::TestCase
  test "responds to a basic query" do
    result = ActiveRecord::Base.connection.execute("SELECT 1 AS result")
    assert_equal 1, result.first["result"]
  end

  test "can write and read a record" do
    user = User.create!(name: "Smoke", email: "smoke@example.com", age: 1)
    assert_equal "smoke@example.com", User.find(user.id).email
  end
end
