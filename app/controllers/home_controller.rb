class HomeController < ApplicationController
  def index
    @total_suspected = City.includes(:covid_informations).map(&:covid_informations).map(&:last).sum(&:suspected)
    @total_confirmed = City.includes(:covid_informations).map(&:covid_informations).map(&:last).sum(&:confirmed)
    @total_deaths = City.includes(:covid_informations).map(&:covid_informations).map(&:last).sum(&:deaths)
    @total_home_isolation = City.includes(:covid_informations).map(&:covid_informations).map(&:last).sum(&:home_isolation)
    @total_hospitalized = City.includes(:covid_informations).map(&:covid_informations).map(&:last).sum(&:hospitalized)
    @total_discarded = City.includes(:covid_informations).map(&:covid_informations).map(&:last).sum(&:discarded)
  end
end

query = "SELECT 'covid_informations'.* FROM 'covid_informations' WHERE 'covid_informations'.'city_id' IN (1,2,3,4,5,6,7,8,9,10,11,12,13)"