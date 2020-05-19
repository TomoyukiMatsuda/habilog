require 'test_helper'

class GoodHabitsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get good_habits_new_url
    assert_response :success
  end

  test "should get create" do
    get good_habits_create_url
    assert_response :success
  end

  test "should get destroy" do
    get good_habits_destroy_url
    assert_response :success
  end

end
