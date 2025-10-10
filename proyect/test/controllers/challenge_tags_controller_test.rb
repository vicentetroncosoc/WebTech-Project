require "test_helper"

class ChallengeTagsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get challenge_tags_index_url
    assert_response :success
  end

  test "should get show" do
    get challenge_tags_show_url
    assert_response :success
  end
end
