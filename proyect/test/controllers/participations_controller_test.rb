require "test_helper"

class ParticipationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get participations_index_url
    assert_response :success
  end

  test "should get show" do
    get participations_show_url
    assert_response :success
  end
end
