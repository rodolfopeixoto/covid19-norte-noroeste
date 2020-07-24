module ImportXls
  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(POSITION_INITIAL)

    ActiveRecord::Base.transaction do
      (2..spreadsheet.last_row).each do |index|

        informations_attributes_hash = Hash[[header, spreadsheet.row(index)].transpose]
        code_ibg = informations_attributes_hash['cod']
        city_id = City.find_by(ibge_code: code_ibg.to_s).id
        reference_at = informations_attributes_hash['data']

        informations_attributes_hash['Curados'] = 0 if informations_attributes_hash['Curados'].nil?

        informations_attributes_hash.delete('cod')
        informations_attributes_hash.delete('city')
        informations_attributes_hash.delete('data')

        informations_attributes_hash_refactory = informations_attributes_hash.merge('city_id' => city_id, 'data' => reference_at.to_date)

        difference_data_reference(informations_attributes_hash_refactory)
      end
    end
  end

  def self.difference_data_reference(informations_attributes_hash)

    information_persisted = CovidInformation.where(reference_at: informations_attributes_hash['data'], city_id: informations_attributes_hash['city_id'])

    return create!(informations_attributes_hash) if count.zero? || information_persisted.blank?

    information_persisted = information_persisted.last

    ## CRIAR UM SCRIPT PARA PODER MODIFICAR A DATA DO ARQUIVO 4/16/2020 TO 16/4/2020
    return if information_persisted.reference_at == informations_attributes_hash['data'] && information_persisted.city_id == informations_attributes_hash['city_id']

    hospitalized = informations_attributes_hash['Hospitalizados'].nil? ? 0 : informations_attributes_hash['Hospitalizados']
    heal = informations_attributes_hash['Curados'].nil? ? 0 : informations_attributes_hash['Curados']
    home_isolations = informations_attributes_hash['Isolamento'].nil? ? 0 : informations_attributes_hash['Isolamento']
    discarded = informations_attributes_hash['Descartados'].nil? ? 0 : informations_attributes_hash['Descartados']
    deaths = informations_attributes_hash['Óbitos'].nil? ? 0 : informations_attributes_hash['Óbitos']
    suspected = informations_attributes_hash['Suspeitos'].nil? ? 0 : informations_attributes_hash['Suspeitos']
    confirmed = informations_attributes_hash['Confirmados'].nil? ? 0 : informations_attributes_hash['Confirmados']
    positive_active = informations_attributes_hash['positivos ativos'].nil? ? 0 : informations_attributes_hash['positivos ativos']

    create(
      {
        "suspected" => suspected,
        "confirmed" => confirmed,
        "home_isolations" => home_isolations,
        "hospitalized" => hospitalized,
        "deaths" => deaths,
        "heal" => heal,
        "discarded"=> discarded,
        "reference_at"=> informations_attributes_hash['data'],
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
