require 'test_helper'

class SpacersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @spacer = spacers(:one)
  end

  test "should get index" do
    get spacers_url
    assert_response :success
  end

  test "should get new" do
    get new_spacer_url
    assert_response :success
  end

  test "should create spacer" do
    assert_difference('Spacer.count') do
      post spacers_url, params: { spacer: { brand_id: @spacer.brand_id, size: @spacer.size } }
    end

    assert_redirected_to spacer_url(Spacer.last)
  end

  test "should show spacer" do
    get spacer_url(@spacer)
    assert_response :success
  end

  test "should get edit" do
    get edit_spacer_url(@spacer)
    assert_response :success
  end

  test "should update spacer" do
    patch spacer_url(@spacer), params: { spacer: { brand_id: @spacer.brand_id, size: @spacer.size } }
    assert_redirected_to spacer_url(@spacer)
  end

  test "should destroy spacer" do
    assert_difference('Spacer.count', -1) do
      delete spacer_url(@spacer)
    end

    assert_redirected_to spacers_url
  end
end
