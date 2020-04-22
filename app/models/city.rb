class City < ApplicationRecord
  belongs_to :region
  has_many :covid_informations

  def self.max_suspected_by_city
    City.joins(:covid_informations)
      .where(covid_informations: { date_reference: CovidInformation.maximum(:date_reference)  } )
      .pluck("cities.name, covid_informations.suspected")
  end

  def self.max_confirmed_by_city
    City.joins(:covid_informations)
      .where(covid_informations: { date_reference: CovidInformation.maximum(:date_reference)  } )
      .pluck("cities.name, covid_informations.confirmed")
  end
end
