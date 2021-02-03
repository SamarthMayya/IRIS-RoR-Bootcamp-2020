require "test_helper"

class AssignmentsControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get assignments_update_url
    assert_response :success
  end

  test "should get destroy" do
    get assignments_destroy_url
    assert_response :success
  end
end
