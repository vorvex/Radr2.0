require 'test_helper'

class PublicViewControllerTest < ActionDispatch::IntegrationTest
  test "should get location" do
    get public_view_location_url
    assert_response :success
  end

  test "should get event" do
    get public_view_event_url
    assert_response :success
  end

  test "should get performer" do
    get public_view_performer_url
    assert_response :success
  end

end
