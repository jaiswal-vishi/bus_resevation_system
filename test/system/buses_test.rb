require "application_system_test_case"

class BusesTest < ApplicationSystemTestCase
  setup do
    @bus = buses(:one)
  end

  test "visiting the index" do
    visit buses_url
    assert_selector "h1", text: "Buses"
  end

  test "should create bus" do
    visit buses_url
    click_on "New bus"

    click_on "Create Bus"

    assert_text "Bus was successfully created"
    click_on "Back"
  end

  test "should update Bus" do
    visit bus_url(@bus)
    click_on "Edit this bus", match: :first

    click_on "Update Bus"

    assert_text "Bus was successfully updated"
    click_on "Back"
  end

  test "should destroy Bus" do
    visit bus_url(@bus)
    click_on "Destroy this bus", match: :first

    assert_text "Bus was successfully destroyed"
  end
end
