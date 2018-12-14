require "application_system_test_case"

class ColorCategoriesTest < ApplicationSystemTestCase
  setup do
    @color_category = color_categories(:one)
  end

  test "visiting the index" do
    visit color_categories_url
    assert_selector "h1", text: "Color Categories"
  end

  test "creating a Color category" do
    visit color_categories_url
    click_on "New Color Category"

    fill_in "Brand", with: @color_category.brand_id
    fill_in "Name", with: @color_category.name
    click_on "Create Color category"

    assert_text "Color category was successfully created"
    click_on "Back"
  end

  test "updating a Color category" do
    visit color_categories_url
    click_on "Edit", match: :first

    fill_in "Brand", with: @color_category.brand_id
    fill_in "Name", with: @color_category.name
    click_on "Update Color category"

    assert_text "Color category was successfully updated"
    click_on "Back"
  end

  test "destroying a Color category" do
    visit color_categories_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Color category was successfully destroyed"
  end
end
