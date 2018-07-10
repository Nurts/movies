require 'test_helper'

class Api::V1::RequestsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_requests_index_url
    assert_response :success
  end

  test "should get cinemas" do
    get api_v1_requests_cinemas_url
    assert_response :success
  end

  test "should get movies" do
    get api_v1_requests_movies_url
    assert_response :success
  end

  test "should get sessions" do
    get api_v1_requests_sessions_url
    assert_response :success
  end

end
