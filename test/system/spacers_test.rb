require "application_system_test_case"

class SpacersTest < ApplicationSystemTestCase
  setup do
    @spacer = spacers(:one)
  end

  test "visiting the index" do
    visit spacers_url
    assert_selector "h1", text: "Spacers"
  end

  test "creating a Spacer" do
    visit spacers_url
    click_on "New Spacer"

    fill_in "Brand", with: @spacer.brand_id
    fill_in "Size", with: @spacer.size
    click_on "Create Spacer"

    assert_text "Spacer was successfully created"
    click_on "Back"
  end

  test "updating a Spacer" do
    visit spacers_url
    click_on "Edit", match: :first

    fill_in "Brand", with: @spacer.brand_id
    fill_in "Size", with: @spacer.size
    click_on "Update Spacer"

    assert_text "Spacer was successfully updated"
    click_on "Back"
  end

  test "destroying a Spacer" do
    visit spacers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Spacer was successfully destroyed"
  end
end
