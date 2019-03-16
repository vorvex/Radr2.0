require 'test_helper'

class PerformerControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get performer_new_url
    assert_response :success
  end

  test "should get edit" do
    get performer_edit_url
    assert_response :success
  end

  test "should get delete" do
    get performer_delete_url
    assert_response :success
  end

end
