class HomeController < ApplicationController
  def index
    @total_suspected = CovidInformation.where('extract(year from date_reference) = 2020').sum(&:suspected)
    @total_confirmed = CovidInformation.where('extract(year from date_reference) = 2020').sum(&:confirmed)
    @total_deaths = CovidInformation.where('extract(year from date_reference) = 2020').sum(&:deaths)
    @total_home_isolation = CovidInformation.where('extract(year from date_reference) = 2020').sum(&:home_isolation)
    @total_hospitalized = CovidInformation.where('extract(year from date_reference) = 2020').sum(&:hospitalized)
    @total_discarded = CovidInformation.where('extract(year from date_reference) = 2020').sum(&:discarded)
  end
end
