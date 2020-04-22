class CovidInformation < ApplicationRecord
  belongs_to :city

  scope :regions_total_confirmed, ->() { CovidInformation.joins(:city).group("covid_informations.date_reference").order("covid_informations.date_reference").sum(:confirmed) }
  scope :regions_total_suspected, ->() { CovidInformation.joins(:city).group("covid_informations.date_reference").order("covid_informations.date_reference").sum(:suspected) }

  def self.sum_confirmed
    CovidInformation.joins(:city).
        group("covid_informations.date_reference").
        order("covid_informations.date_reference").
        sum(:confirmed) 
  end

  def self.sum_deaths
    CovidInformation.joins(:city).
    group("covid_informations.date_reference").
    order("covid_informations.date_reference").
    sum(:deaths)
  end

  def self.sum_suspected
    CovidInformation.joins(:city).
    group("covid_informations.date_reference").
    order("covid_informations.date_reference").
    sum(:suspected)
  end

  def self.cases_deaths_and_confirmed
    [
      { name: "Óbitos", data: sum_deaths },
      { name: 'Confirmados', data: sum_confirmed }
    ]
  end

  def self.chart_cities_norte_confirmed
    cities = City.includes(:covid_informations, :region).where("cities.region_id = 2")
     cities.map do |city|
       {
         name: city.name,
         data: CovidInformation.includes(:city).where(covid_informations: { city_id: city.id} ).group("covid_informations.date_reference, covid_informations.confirmed").order("covid_informations.date_reference").pluck("covid_informations.date_reference, covid_informations.confirmed")
       }
    end
  end

  def self.chart_cities_noroeste_confirmed
    cities = City.includes(:covid_informations, :region).where("cities.region_id = 1")
     cities.map do |city|
       {
         name: city.name,
         data: CovidInformation.includes(:city).where(covid_informations: { city_id: city.id} ).group("covid_informations.date_reference, covid_informations.confirmed").order("covid_informations.date_reference").pluck("covid_informations.date_reference, covid_informations.confirmed")
       }
    end
  end
end
