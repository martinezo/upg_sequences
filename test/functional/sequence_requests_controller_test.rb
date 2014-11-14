require 'test_helper'

class SequenceRequestsControllerTest < ActionController::TestCase
  setup do
    @sequence_request = sequence_requests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sequence_requests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sequence_request" do
    assert_difference('SequenceRequest.count') do
      post :create, :sequence_request => @sequence_request.attributes
    end

    assert_redirected_to sequence_request_path(assigns(:sequence_request))
  end

  test "should show sequence_request" do
    get :show, :id => @sequence_request.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @sequence_request.to_param
    assert_response :success
  end

  test "should update sequence_request" do
    put :update, :id => @sequence_request.to_param, :sequence_request => @sequence_request.attributes
    assert_redirected_to sequence_request_path(assigns(:sequence_request))
  end

  test "should destroy sequence_request" do
    assert_difference('SequenceRequest.count', -1) do
      delete :destroy, :id => @sequence_request.to_param
    end

    assert_redirected_to sequence_requests_path
  end
end
