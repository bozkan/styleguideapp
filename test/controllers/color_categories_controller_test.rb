require 'test_helper'

class ColorCategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @color_category = color_categories(:one)
  end

  test "should get index" do
    get color_categories_url
    assert_response :success
  end

  test "should get new" do
    get new_color_category_url
    assert_response :success
  end

  test "should create color_category" do
    assert_difference('ColorCategory.count') do
      post color_categories_url, params: { color_category: { brand_id: @color_category.brand_id, name: @color_category.name } }
    end

    assert_redirected_to color_category_url(ColorCategory.last)
  end

  test "should show color_category" do
    get color_category_url(@color_category)
    assert_response :success
  end

  test "should get edit" do
    get edit_color_category_url(@color_category)
    assert_response :success
  end

  test "should update color_category" do
    patch color_category_url(@color_category), params: { color_category: { brand_id: @color_category.brand_id, name: @color_category.name } }
    assert_redirected_to color_category_url(@color_category)
  end

  test "should destroy color_category" do
    assert_difference('ColorCategory.count', -1) do
      delete color_category_url(@color_category)
    end

    assert_redirected_to color_categories_url
  end
end
