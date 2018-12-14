require "application_system_test_case"

class FontsTest < ApplicationSystemTestCase
  setup do
    @font = fonts(:one)
  end

  test "visiting the index" do
    visit fonts_url
    assert_selector "h1", text: "Fonts"
  end

  test "creating a Font" do
    visit fonts_url
    click_on "New Font"

    fill_in "Brand", with: @font.brand_id
    fill_in "Line height", with: @font.line_height
    fill_in "Name", with: @font.name
    fill_in "Size", with: @font.size
    fill_in "Weight", with: @font.weight
    click_on "Create Font"

    assert_text "Font was successfully created"
    click_on "Back"
  end

  test "updating a Font" do
    visit fonts_url
    click_on "Edit", match: :first

    fill_in "Brand", with: @font.brand_id
    fill_in "Line height", with: @font.line_height
    fill_in "Name", with: @font.name
    fill_in "Size", with: @font.size
    fill_in "Weight", with: @font.weight
    click_on "Update Font"

    assert_text "Font was successfully updated"
    click_on "Back"
  end

  test "destroying a Font" do
    visit fonts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Font was successfully destroyed"
  end
end
