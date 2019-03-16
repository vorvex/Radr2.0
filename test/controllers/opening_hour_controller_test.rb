require 'test_helper'

class OpeningHourControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get opening_hour_new_url
    assert_response :success
  end

  test "should get edit" do
    get opening_hour_edit_url
    assert_response :success
  end

  test "should get delete" do
    get opening_hour_delete_url
    assert_response :success
  end

end
