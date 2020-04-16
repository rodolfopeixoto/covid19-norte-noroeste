require 'test_helper'

class CovidInformationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @covid_information = covid_informations(:one)
  end

  test "should get index" do
    get covid_informations_url
    assert_response :success
  end

  test "should get new" do
    get new_covid_information_url
    assert_response :success
  end

  test "should create covid_information" do
    assert_difference('CovidInformation.count') do
      post covid_informations_url, params: { covid_information: { city_id: @covid_information.city_id, confirmed: @covid_information.confirmed, date_reference: @covid_information.date_reference, deaths: @covid_information.deaths, discarded: @covid_information.discarded, home_isolation: @covid_information.home_isolation, hospitalized: @covid_information.hospitalized, suspected: @covid_information.suspected } }
    end

    assert_redirected_to covid_information_url(CovidInformation.last)
  end

  test "should show covid_information" do
    get covid_information_url(@covid_information)
    assert_response :success
  end

  test "should get edit" do
    get edit_covid_information_url(@covid_information)
    assert_response :success
  end

  test "should update covid_information" do
    patch covid_information_url(@covid_information), params: { covid_information: { city_id: @covid_information.city_id, confirmed: @covid_information.confirmed, date_reference: @covid_information.date_reference, deaths: @covid_information.deaths, discarded: @covid_information.discarded, home_isolation: @covid_information.home_isolation, hospitalized: @covid_information.hospitalized, suspected: @covid_information.suspected } }
    assert_redirected_to covid_information_url(@covid_information)
  end

  test "should destroy covid_information" do
    assert_difference('CovidInformation.count', -1) do
      delete covid_information_url(@covid_information)
    end

    assert_redirected_to covid_informations_url
  end
end
