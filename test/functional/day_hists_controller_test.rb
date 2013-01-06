require 'test_helper'

class DayHistsControllerTest < ActionController::TestCase
  setup do
    @day_hist = day_hists(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:day_hists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create day_hist" do
    assert_difference('DayHist.count') do
      post :create, day_hist: {  }
    end

    assert_redirected_to day_hist_path(assigns(:day_hist))
  end

  test "should show day_hist" do
    get :show, id: @day_hist
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @day_hist
    assert_response :success
  end

  test "should update day_hist" do
    put :update, id: @day_hist, day_hist: {  }
    assert_redirected_to day_hist_path(assigns(:day_hist))
  end

  test "should destroy day_hist" do
    assert_difference('DayHist.count', -1) do
      delete :destroy, id: @day_hist
    end

    assert_redirected_to day_hists_path
  end
end
