class Region < ApplicationRecord
  has_many :cities

  def self.confirmed_by_region_norte
    Region.find(2).cities.includes(:covid_informations).
    where(covid_informations: { date_reference: CovidInformation.maximum(:date_reference)  } ).
    group(["cities.name","covid_informations.confirmed"]).
    order('covid_informations.confirmed DESC').
    pluck("cities.name, covid_informations.confirmed") 
  end

  def self.confirmed_by_region_noroeste
    Region.find(1).cities.includes(:covid_informations).
    where(covid_informations: { date_reference: CovidInformation.maximum(:date_reference)  } ).
    group(["cities.name","covid_informations.confirmed"]).
    order('covid_informations.confirmed DESC').
    pluck("cities.name, covid_informations.confirmed")
  end
end
