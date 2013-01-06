require 'test_helper'

class DayhistUpdaterControllerTest < ActionController::TestCase
  test "should get tedhist" do
    get :tedhist
    assert_response :success
  end

end
