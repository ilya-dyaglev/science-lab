require "test_helper"

class ExperimentsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get experiments_show_url
    assert_response :success
  end
end
