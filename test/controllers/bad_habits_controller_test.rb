require 'test_helper'

class BadHabitsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get bad_habits_new_url
    assert_response :success
  end

end
