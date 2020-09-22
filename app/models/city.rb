class City < ApplicationRecord
  belongs_to :region
  has_many :covid_informations

  def self.max_suspected_by_city
    CovidInformation.includes(:city).
    where(covid_informations: { date_reference: CovidInformation.maximum(:date_reference)  } ).
    group(["cities.name","covid_informations.suspected"]).
    order('covid_informations.suspected DESC').
    pluck("cities.name, covid_informations.suspected")
  end

  def self.max_confirmed_by_city
    CovidInformation.includes(:city).
    where(covid_informations: { date_reference: CovidInformation.maximum(:date_reference)  } ).
    group(["cities.name","covid_informations.confirmed"]).
    order('covid_informations.confirmed DESC').
    pluck("cities.name, covid_informations.confirmed")
  end

  def self.max_positive_active_by_city
    CovidInformation.includes(:city).
    where(covid_informations: { date_reference: CovidInformation.maximum(:date_reference)  } ).
    group(["cities.name","covid_informations.positive_active"]).
    order('covid_informations.positive_active DESC').
    pluck("cities.name, covid_informations.positive_active")
  end
end
