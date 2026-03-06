require "test_helper"

class EventsControllerTest < ActionDispatch::IntegrationTest
  include MongoidTestHelper

  setup do
    @event = Event.create!(name: "user.signed_up", category: "auth", metadata: { ip: "1.2.3.4" })
  end

  test "GET /events returns all events" do
    get events_url
    assert_response :ok
    assert_equal 1, JSON.parse(response.body).size
  end

  test "GET /events/:id returns the event" do
    get event_url(@event)
    assert_response :ok
    assert_equal @event.id.to_s, JSON.parse(response.body)["_id"]
  end

  test "GET /events/:id returns 404 for unknown event" do
    get event_url(id: "000000000000000000000000")
    assert_response :not_found
  end

  test "POST /events creates an event with metadata" do
    post events_url,
         params: { event: { name: "page.viewed", category: "analytics", metadata: { path: "/home" } } },
         as: :json
    assert_response :created
    body = JSON.parse(response.body)
    assert_equal "page.viewed", body["name"]
  end

  test "POST /events returns 422 with invalid params" do
    post events_url, params: { event: { name: "", category: "" } }, as: :json
    assert_response :unprocessable_entity
    assert JSON.parse(response.body)["errors"].present?
  end

  test "PATCH /events/:id updates the event" do
    patch event_url(@event), params: { event: { category: "security" } }, as: :json
    assert_response :ok
    assert_equal "security", JSON.parse(response.body)["category"]
  end

  test "DELETE /events/:id deletes the event" do
    delete event_url(@event)
    assert_response :no_content
    assert_equal 0, Event.count
  end
end
