require 'test_helper'

class TicketControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get ticket_new_url
    assert_response :success
  end

  test "should get edit" do
    get ticket_edit_url
    assert_response :success
  end

  test "should get delete" do
    get ticket_delete_url
    assert_response :success
  end

end
