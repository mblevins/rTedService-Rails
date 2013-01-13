require 'test_helper'

class SolarImgControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
