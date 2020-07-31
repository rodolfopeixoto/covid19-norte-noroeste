class CovidInformation < ApplicationRecord


  POSITION_INITIAL = 1

  paginates_per 22

  belongs_to :city
  # total confirmed por semana
  # result = conn.execute "SELECT SUM(confirmed) as total_by_week, date_trunc('week', CAST(date_reference AS DATE)) weekly FROM covid_informations GROUP BY weekly ORDER BY weekly;"

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

  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(POSITION_INITIAL)

    ActiveRecord::Base.transaction do
      (2..spreadsheet.last_row).each do |index|
        informations_attributes_hash = Hash[[header, spreadsheet.row(index)].transpose]
        code_ibge = informations_attributes_hash['cod'].to_i
        city_id = City.find_by(ibge_code: code_ibge.to_s)&.id
        date_reference = informations_attributes_hash['date_reference']

        informations_attributes_hash['heal'] = 0 if informations_attributes_hash['heal'].nil?

        informations_attributes_hash.delete('cod')
        informations_attributes_hash.delete('city')
        informations_attributes_hash.delete('date_reference')

        informations_attributes_hash_refactory = informations_attributes_hash.merge('city_id' => city_id, 'date_reference' => date_reference.to_date)

        difference_data_reference(informations_attributes_hash_refactory)
      end
    end
  end

  def self.difference_data_reference(informations_attributes_hash)

    information_persisted = CovidInformation.where(date_reference: informations_attributes_hash['date_reference'], city_id: informations_attributes_hash['city_id'])
    return if information_persisted.exists?

    hospitalized = informations_attributes_hash['hospitalized'].nil? ? 0 : informations_attributes_hash['hospitalized']
    heal = informations_attributes_hash['heal'].nil? ? 0 : informations_attributes_hash['heal']
    home_isolations = informations_attributes_hash['home_isolation'].nil? ? 0 : informations_attributes_hash['home_isolation']
    discarded = informations_attributes_hash['discarded'].nil? ? 0 : informations_attributes_hash['discarded']
    deaths = informations_attributes_hash['deaths'].nil? ? 0 : informations_attributes_hash['deaths']
    suspected = informations_attributes_hash['suspected'].nil? ? 0 : informations_attributes_hash['suspected']
    confirmed = informations_attributes_hash['confirmed'].nil? ? 0 : informations_attributes_hash['confirmed']
    positive_active = informations_attributes_hash['positive_active'].nil? ? 0 : informations_attributes_hash['positive_active']

    create(
      {
        "suspected" => suspected,
        "confirmed" => confirmed,
        "home_isolation" => home_isolations,
        "hospitalized" => hospitalized,
        "deaths" => deaths,
        "heal" => heal,
        "discarded"=> discarded,
        "date_reference"=> informations_attributes_hash['date_reference'],
        "city_id" => informations_attributes_hash['city_id'],
        "positive_active" => positive_active
      }
    )
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::CSV.new(file.path)
    when ".xls" then Roo::Excelx.new(file.path)
    when ".xlsx" then Roo::Excelx.new(file.path)
    else raise "Unknow file type: #{file.original_filename}"
    end
  end


end
