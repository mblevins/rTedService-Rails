require 'test_helper'

class TedDataControllerTest < ActionController::TestCase
  setup do
    @ted_datum = ted_data(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ted_data)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ted_datum" do
    assert_difference('TedDatum.count') do
      post :create, ted_datum: { cumtime: @ted_datum.cumtime, mtu: @ted_datum.mtu, mtype: @ted_datum.mtype, watts: @ted_datum.watts }
    end

    assert_redirected_to ted_datum_path(assigns(:ted_datum))
  end

  test "should show ted_datum" do
    get :show, id: @ted_datum
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ted_datum
    assert_response :success
  end

  test "should update ted_datum" do
    put :update, id: @ted_datum, ted_datum: { cumtime: @ted_datum.cumtime, mtu: @ted_datum.mtu, mtype: @ted_datum.mtype, watts: @ted_datum.watts }
    assert_redirected_to ted_datum_path(assigns(:ted_datum))
  end

  test "should destroy ted_datum" do
    assert_difference('TedDatum.count', -1) do
      delete :destroy, id: @ted_datum
    end

    assert_redirected_to ted_data_path
  end
end
