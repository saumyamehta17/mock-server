require 'test_helper'

class EndpointsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @endpoint = endpoints(:one)
  end

  test "should get index" do
    get endpoints_url, as: :json
    assert_response :success
  end

  test "should create endpoint" do
    assert_difference('Endpoint.count') do
      post endpoints_url, params: { endpoint: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show endpoint" do
    get endpoint_url(@endpoint), as: :json
    assert_response :success
  end

  test "should update endpoint" do
    patch endpoint_url(@endpoint), params: { endpoint: {  } }, as: :json
    assert_response 200
  end

  test "should destroy endpoint" do
    assert_difference('Endpoint.count', -1) do
      delete endpoint_url(@endpoint), as: :json
    end

    assert_response 204
  end
end
