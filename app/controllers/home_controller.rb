class HomeController < ApplicationController
  def index
    @total_suspected = City.includes(:covid_informations).map(&:covid_informations).map(&:last).sum(&:suspected)
    @total_confirmed = City.includes(:covid_informations).map(&:covid_informations).map(&:last).sum(&:confirmed)
    @total_deaths = City.includes(:covid_informations).map(&:covid_informations).map(&:last).sum(&:deaths)
    @total_home_isolation = City.includes(:covid_informations).map(&:covid_informations).map(&:last).sum(&:home_isolation)
    @total_hospitalized = City.includes(:covid_informations).map(&:covid_informations).map(&:last).sum(&:hospitalized)
    @total_discarded = City.includes(:covid_informations).map(&:covid_informations).map(&:last).sum(&:discarded)
    @total_heal = City.includes(:covid_informations).map(&:covid_informations).map(&:last).sum(&:heal)
    @chart_cities_norte_confirmed = CovidInformation.chart_cities_norte_confirmed
    @chart_cities_noroeste_confirmed = CovidInformation.chart_cities_noroeste_confirmed
    @cases_deaths_and_confirmed = CovidInformation.cases_deaths_and_confirmed
    @sum_suspected = CovidInformation.sum_suspected
    @sum_deaths = CovidInformation.sum_deaths
    @sum_confirmed = CovidInformation.sum_confirmed
    @max_suspected_by_city = City.max_suspected_by_city
    @max_confirmed_by_city = City.max_confirmed_by_city
    @region_norte = Region.confirmed_by_region_norte
    @region_noroeste = Region.confirmed_by_region_noroeste
  end
end
