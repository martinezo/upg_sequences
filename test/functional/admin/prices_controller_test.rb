require 'test_helper'

class Admin::PricesControllerTest < ActionController::TestCase
  setup do
    @admin_price = admin_prices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_prices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_price" do
    assert_difference('Admin::Price.count') do
      post :create, :admin_price => @admin_price.attributes
    end

    assert_redirected_to admin_price_path(assigns(:admin_price))
  end

  test "should show admin_price" do
    get :show, :id => @admin_price.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @admin_price.to_param
    assert_response :success
  end

  test "should update admin_price" do
    put :update, :id => @admin_price.to_param, :admin_price => @admin_price.attributes
    assert_redirected_to admin_price_path(assigns(:admin_price))
  end

  test "should destroy admin_price" do
    assert_difference('Admin::Price.count', -1) do
      delete :destroy, :id => @admin_price.to_param
    end

    assert_redirected_to admin_prices_path
  end
end
