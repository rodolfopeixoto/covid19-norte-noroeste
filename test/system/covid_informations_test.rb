require "application_system_test_case"

class CovidInformationsTest < ApplicationSystemTestCase
  setup do
    @covid_information = covid_informations(:one)
  end

  test "visiting the index" do
    visit covid_informations_url
    assert_selector "h1", text: "Covid Informations"
  end

  test "creating a Covid information" do
    visit covid_informations_url
    click_on "New Covid Information"

    fill_in "City", with: @covid_information.city_id
    fill_in "Confirmed", with: @covid_information.confirmed
    fill_in "Date reference", with: @covid_information.date_reference
    fill_in "Deaths", with: @covid_information.deaths
    fill_in "Discarded", with: @covid_information.discarded
    fill_in "Home isolation", with: @covid_information.home_isolation
    fill_in "Hospitalized", with: @covid_information.hospitalized
    fill_in "Suspected", with: @covid_information.suspected
    click_on "Create Covid information"

    assert_text "Covid information was successfully created"
    click_on "Back"
  end

  test "updating a Covid information" do
    visit covid_informations_url
    click_on "Edit", match: :first

    fill_in "City", with: @covid_information.city_id
    fill_in "Confirmed", with: @covid_information.confirmed
    fill_in "Date reference", with: @covid_information.date_reference
    fill_in "Deaths", with: @covid_information.deaths
    fill_in "Discarded", with: @covid_information.discarded
    fill_in "Home isolation", with: @covid_information.home_isolation
    fill_in "Hospitalized", with: @covid_information.hospitalized
    fill_in "Suspected", with: @covid_information.suspected
    click_on "Update Covid information"

    assert_text "Covid information was successfully updated"
    click_on "Back"
  end

  test "destroying a Covid information" do
    visit covid_informations_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Covid information was successfully destroyed"
  end
end
