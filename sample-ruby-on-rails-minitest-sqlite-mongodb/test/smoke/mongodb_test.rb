require "test_helper"

class MongodbConnectivityTest < ActiveSupport::TestCase
  include MongoidTestHelper
  test "responds to a ping" do
    result = Mongoid.client(:default).database.command(ping: 1)
    assert_equal 1, result.first["ok"]
  end

  test "can write and read a document" do
    event = Event.create!(name: "smoke.test", category: "smoke")
    assert_equal "smoke.test", Event.find(event.id).name
  end
end
