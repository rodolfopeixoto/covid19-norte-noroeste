class Region < ApplicationRecord
  has_many :cities

  def self.confirmed_by_region_norte
    Region.find(2).cities.includes(:covid_informations).
    where(covid_informations: { date_reference: CovidInformation.maximum(:date_reference)  } ).
    group(["cities.name","covid_informations.confirmed"]).
    order('covid_informations.confirmed DESC').
    pluck("cities.name, covid_informations.confirmed")
  end

  def self.positive_active_by_region_norte
    Region.find(2).cities.includes(:covid_informations).
    where(covid_informations: { date_reference: CovidInformation.maximum(:date_reference)  } ).
    group(["cities.name","covid_informations.positive_active"]).
    order('covid_informations.positive_active DESC').
    pluck("cities.name, covid_informations.positive_active")
  end

  def self.confirmed_by_region_noroeste
    Region.find(1).cities.includes(:covid_informations).
    where(covid_informations: { date_reference: CovidInformation.maximum(:date_reference)  } ).
    group(["cities.name","covid_informations.confirmed"]).
    order('covid_informations.confirmed DESC').
    pluck("cities.name, covid_informations.confirmed")
  end

  def self.positive_active_by_region_noroeste
    Region.find(1).cities.includes(:covid_informations).
    where(covid_informations: { date_reference: CovidInformation.maximum(:date_reference)  } ).
    group(["cities.name","covid_informations.positive_active"]).
    order('covid_informations.positive_active DESC').
    pluck("cities.name, covid_informations.positive_active")
  end

  def self.suspected_noroeste
    Region.find(1).cities.includes(:covid_informations).where(covid_informations: { date_reference: CovidInformation.maximum(:date_reference)  } ).
    group(["cities.name","covid_informations.suspected"]).
    order('covid_informations.suspected DESC').
    pluck("cities.name, covid_informations.suspected")
  end

  def self.suspected_norte
    Region.find(2).cities.includes(:covid_informations).where(covid_informations: { date_reference: CovidInformation.maximum(:date_reference)  } ).
    group(["cities.name","covid_informations.suspected"]).
    order('covid_informations.suspected DESC').
    pluck("cities.name, covid_informations.suspected")
  end
end
