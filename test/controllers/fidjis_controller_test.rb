require 'test_helper'

class FidjisControllerTest < ActionDispatch::IntegrationTest
  setup do
    @fidji = fidjis(:one)
  end

  test "should get index" do
    get fidjis_url
    assert_response :success
  end

  test "should get new" do
    get new_fidji_url
    assert_response :success
  end

  test "should create fidji" do
    assert_difference('Fidji.count') do
      post fidjis_url, params: { fidji: { family: @fidji.family, name: @fidji.name } }
    end

    assert_redirected_to fidji_url(Fidji.last)
  end

  test "should show fidji" do
    get fidji_url(@fidji)
    assert_response :success
  end

  test "should get edit" do
    get edit_fidji_url(@fidji)
    assert_response :success
  end

  test "should update fidji" do
    patch fidji_url(@fidji), params: { fidji: { family: @fidji.family, name: @fidji.name } }
    assert_redirected_to fidji_url(@fidji)
  end

  test "should destroy fidji" do
    assert_difference('Fidji.count', -1) do
      delete fidji_url(@fidji)
    end

    assert_redirected_to fidjis_url
  end
end
