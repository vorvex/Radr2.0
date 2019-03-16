require 'test_helper'

class SocialLinkControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get social_link_new_url
    assert_response :success
  end

  test "should get edit" do
    get social_link_edit_url
    assert_response :success
  end

  test "should get delete" do
    get social_link_delete_url
    assert_response :success
  end

end
