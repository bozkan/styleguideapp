require 'test_helper'

class FontsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @font = fonts(:one)
  end

  test "should get index" do
    get fonts_url
    assert_response :success
  end

  test "should get new" do
    get new_font_url
    assert_response :success
  end

  test "should create font" do
    assert_difference('Font.count') do
      post fonts_url, params: { font: { brand_id: @font.brand_id, line_height: @font.line_height, name: @font.name, size: @font.size, weight: @font.weight } }
    end

    assert_redirected_to font_url(Font.last)
  end

  test "should show font" do
    get font_url(@font)
    assert_response :success
  end

  test "should get edit" do
    get edit_font_url(@font)
    assert_response :success
  end

  test "should update font" do
    patch font_url(@font), params: { font: { brand_id: @font.brand_id, line_height: @font.line_height, name: @font.name, size: @font.size, weight: @font.weight } }
    assert_redirected_to font_url(@font)
  end

  test "should destroy font" do
    assert_difference('Font.count', -1) do
      delete font_url(@font)
    end

    assert_redirected_to fonts_url
  end
end
