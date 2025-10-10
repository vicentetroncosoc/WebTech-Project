require "test_helper"

class UserBadgesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_badges_index_url
    assert_response :success
  end

  test "should get show" do
    get user_badges_show_url
    assert_response :success
  end
end
