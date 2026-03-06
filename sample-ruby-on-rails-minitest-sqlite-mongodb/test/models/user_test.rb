require "test_helper"

class UserTest < ActiveSupport::TestCase
  def valid_attributes
    { name: "Alice", email: "alice@example.com", age: 30 }
  end

  test "is valid with valid attributes" do
    assert User.new(valid_attributes).valid?
  end

  test "is invalid without a name" do
    user = User.new(valid_attributes.merge(name: nil))
    assert_not user.valid?
    assert_includes user.errors[:name], "can't be blank"
  end

  test "is invalid without an email" do
    user = User.new(valid_attributes.merge(email: nil))
    assert_not user.valid?
    assert_includes user.errors[:email], "can't be blank"
  end

  test "is invalid with a malformed email" do
    user = User.new(valid_attributes.merge(email: "not-an-email"))
    assert_not user.valid?
    assert_includes user.errors[:email], "is invalid"
  end

  test "is invalid with a duplicate email (case-insensitive)" do
    User.create!(valid_attributes)
    duplicate = User.new(valid_attributes.merge(email: "ALICE@EXAMPLE.COM"))
    assert_not duplicate.valid?
    assert_includes duplicate.errors[:email], "has already been taken"
  end

  test "is invalid with age of zero" do
    user = User.new(valid_attributes.merge(age: 0))
    assert_not user.valid?
  end

  test "is invalid with a negative age" do
    user = User.new(valid_attributes.merge(age: -1))
    assert_not user.valid?
  end

  test "is invalid with a non-integer age" do
    user = User.new(valid_attributes.merge(age: 25.5))
    assert_not user.valid?
  end
end
