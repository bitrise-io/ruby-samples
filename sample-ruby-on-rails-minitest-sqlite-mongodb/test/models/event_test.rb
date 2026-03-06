require "test_helper"

class EventTest < ActiveSupport::TestCase
  include MongoidTestHelper
  def valid_attributes
    { name: "user.signed_up", category: "auth", metadata: { ip: "1.2.3.4" } }
  end

  test "is valid with valid attributes" do
    assert Event.new(valid_attributes).valid?
  end

  test "is invalid without a name" do
    event = Event.new(valid_attributes.merge(name: nil))
    assert_not event.valid?
    assert_includes event.errors[:name], "can't be blank"
  end

  test "is invalid without a category" do
    event = Event.new(valid_attributes.merge(category: nil))
    assert_not event.valid?
    assert_includes event.errors[:category], "can't be blank"
  end

  test "stores arbitrary metadata" do
    event = Event.create!(valid_attributes.merge(metadata: { user_id: 42, plan: "pro", tags: ["new"] }))
    found = Event.find(event.id)
    assert_equal 42, found.metadata["user_id"]
    assert_equal "pro", found.metadata["plan"]
  end

  test "defaults metadata to an empty hash" do
    event = Event.create!(name: "page.viewed", category: "analytics")
    assert_equal({}, Event.find(event.id).metadata)
  end

  test "sets timestamps on create" do
    event = Event.create!(valid_attributes)
    assert_not_nil event.created_at
    assert_not_nil event.updated_at
  end
end
