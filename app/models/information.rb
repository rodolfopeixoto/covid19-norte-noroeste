class Information < ApplicationRecord

  POSITION_INITIAL = 1

  belongs_to :city

  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(POSITION_INITIAL)
    (2..spreadsheet.last_row).each do |index|

      informations_attributes_hash = Hash[[header, spreadsheet.row(index)].transpose]
      code_ibg = informations_attributes_hash['code_ibge']
      city_id = City.find_by(ibge_code: code_ibg.to_s).id
      reference_at = informations_attributes_hash['reference_at']

      informations_attributes_hash['heal'] = 0 if informations_attributes_hash['heal'].nil?

      informations_attributes_hash.delete('code_ibge')
      informations_attributes_hash.delete('city')
      informations_attributes_hash.delete('reference_at')

      informations_attributes_hash_refactory = informations_attributes_hash.merge('city_id' => city_id, 'reference_at' => reference_at.to_date)

      difference_data_reference(informations_attributes_hash_refactory)
    end
  end

  def self.difference_data_reference(informations_attributes_hash)

    information_persisted = Information.where(reference_at: informations_attributes_hash['reference_at'] - 1.day, city_id: informations_attributes_hash['city_id'])

    return create!(informations_attributes_hash) if count.zero?
    return create!(informations_attributes_hash) if information_persisted.blank?

    information_persisted = information_persisted.last

    ## CRIAR UM SCRIPT PARA PODER MODIFICAR A DATA DO ARQUIVO 4/16/2020 TO 16/4/2020
    return if information_persisted.reference_at == informations_attributes_hash['reference_at'] && information_persisted.city_id == informations_attributes_hash['city_id']

    hospitalized = informations_attributes_hash['hospitalized'].nil? ? 0 : informations_attributes_hash['hospitalized']
    heal = informations_attributes_hash['heal'].nil? ? 0 : informations_attributes_hash['heal']
    home_isolations = informations_attributes_hash['home_isolations'].nil? ? 0 : informations_attributes_hash['home_isolations']
    discarded = informations_attributes_hash['discarded'].nil? ? 0 : informations_attributes_hash['discarded']
    deaths = informations_attributes_hash['deaths'].nil? ? 0 : informations_attributes_hash['deaths']
    suspected = informations_attributes_hash['suspected'].nil? ? 0 : informations_attributes_hash['suspected']
    confirmed = informations_attributes_hash['confirmed'].nil? ? 0 : informations_attributes_hash['confirmed']

    suspected = suspected.zero? ? 0 : suspected - information_persisted.suspected
    confirmed = confirmed.zero? ? 0 : confirmed - information_persisted.confirmed
    home_isolations = home_isolations.zero? ? 0 : home_isolations - information_persisted.home_isolations
    hospitalized = hospitalized.zero? ? 0 : hospitalized - information_persisted.hospitalized
    deaths = deaths.zero? ? 0 : deaths - information_persisted.deaths
    heal = heal.zero? ? 0 : heal - information_persisted.heal
    discarded = discarded.zero? ? 0 : discarded - information_persisted.discarded

    create(
      {
        "suspected" => suspected,
        "confirmed" => confirmed,
        "home_isolations" => home_isolations,
        "hospitalized" => hospitalized,
        "deaths" => deaths,
        "heal" => heal,
        "discarded"=> discarded,
        "reference_at"=> informations_attributes_hash['reference_at'],
        "city_id" => informations_attributes_hash['city_id']
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
