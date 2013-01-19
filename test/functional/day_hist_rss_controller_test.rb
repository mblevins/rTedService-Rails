require 'test_helper'

class DayHistRssControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
