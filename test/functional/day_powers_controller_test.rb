require 'test_helper'

class DayPowersControllerTest < ActionController::TestCase
  setup do
    @day_power = day_powers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:day_powers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create day_power" do
    assert_difference('DayPower.count') do
      post :create, day_power: { day: @day_power.day, pgeWatts: @day_power.pgeWatts, solarWatts: @day_power.solarWatts, waterWatts: @day_power.waterWatts }
    end

    assert_redirected_to day_power_path(assigns(:day_power))
  end

  test "should show day_power" do
    get :show, id: @day_power
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @day_power
    assert_response :success
  end

  test "should update day_power" do
    put :update, id: @day_power, day_power: { day: @day_power.day, pgeWatts: @day_power.pgeWatts, solarWatts: @day_power.solarWatts, waterWatts: @day_power.waterWatts }
    assert_redirected_to day_power_path(assigns(:day_power))
  end

  test "should destroy day_power" do
    assert_difference('DayPower.count', -1) do
      delete :destroy, id: @day_power
    end

    assert_redirected_to day_powers_path
  end
end
