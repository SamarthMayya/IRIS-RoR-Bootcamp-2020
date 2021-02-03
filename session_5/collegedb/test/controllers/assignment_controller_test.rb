require "test_helper"

class AssignmentControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get assignment_create_url
    assert_response :success
  end
end
