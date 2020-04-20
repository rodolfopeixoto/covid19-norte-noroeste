require 'roo'
namespace :data_marco do
  task create: :environment do
      noroeste = Region.find_or_create_by!(name: 'Noroeste Fluminense')
      norte = Region.find_or_create_by!(name: 'Norte Fluminense')

      City.find_or_create_by!(name: 'Aperibé', ibge_code: '3300159', region_id: noroeste.id)
      City.find_or_create_by!(name: 'Bom Jesus do Itabapoana', ibge_code: '3300605', region_id: noroeste.id)
      City.find_or_create_by!(name: 'Cambuci', ibge_code: '3300902', region_id: noroeste.id)
      City.find_or_create_by!(name: 'Italva', ibge_code: '3302056', region_id: noroeste.id)
      City.find_or_create_by!(name: 'Itaocara', ibge_code: '3302106', region_id: noroeste.id)
      City.find_or_create_by!(name: 'Itaperuna', ibge_code: '3302205', region_id: noroeste.id)
      City.find_or_create_by!(name: 'Laje do Muriaé', ibge_code: '3302304', region_id: noroeste.id)
      City.find_or_create_by!(name: 'Miracema', ibge_code: '3303005', region_id: noroeste.id)
      City.find_or_create_by!(name: 'Natividade', ibge_code: '3303104', region_id: noroeste.id)
      City.find_or_create_by!(name: 'Porciúncula', ibge_code: '3304102', region_id: noroeste.id)
      City.find_or_create_by!(name: 'Santo Antônio de Pádua', ibge_code: '3304706', region_id: noroeste.id)
      City.find_or_create_by!(name: 'São José de Ubá', ibge_code: '3305133', region_id: noroeste.id)
      City.find_or_create_by!(name: 'Varre-Sai', ibge_code: '3306156', region_id: noroeste.id)

      City.find_or_create_by!(name: 'Campos dos Goytacazes', ibge_code: '3301009', region_id: norte.id)
      City.find_or_create_by!(name: 'Carapebus', ibge_code: '3300936', region_id: norte.id)
      City.find_or_create_by!(name: 'Cardoso Moreira', ibge_code: '3301157', region_id: norte.id)
      City.find_or_create_by!(name: 'Conceição de Macabu', ibge_code: '3301405', region_id: norte.id)
      City.find_or_create_by!(name: 'Macaé', ibge_code: '3302403', region_id: norte.id)
      City.find_or_create_by!(name: 'Quissamã', ibge_code: '3304151', region_id: norte.id)
      City.find_or_create_by!(name: 'São Fidélis', ibge_code: '3304805', region_id: norte.id)
      City.find_or_create_by!(name: 'São Francisco de Itabapoana', ibge_code: '3304755', region_id: norte.id)
      City.find_or_create_by!(name: 'São João da Barra', ibge_code: '3305000', region_id: norte.id)
      path = Rails.root.join('lib', 'tasks', 'covid_mar_abr.xlsx').to_s
      xlsx = Roo::Spreadsheet.open(path)

      xlsx.sheets.each do |sheet_name|
        sheet = xlsx.sheet(sheet_name)
        last_row    = sheet.last_row
        last_column = sheet.last_column

        for row in 2..last_row
            date_reference = sheet.cell(row, 10)

            city_name_clean = sheet.cell(row, 2).sub(/\A[^\w\s]+/,'')

            home_isolation = sheet.cell(row, 5).to_i
            home_isolation_condiction = home_isolation == '-' ? 0 : home_isolation
  
            hospitalized = sheet.cell(row, 6).to_i
            hospitalized_condiction = hospitalized == '-' ? 0 : hospitalized


            discarded = sheet.cell(row, 7).to_i
            discarded_condiction = discarded == '-' ? 0 : discarded

            CovidInformation.create(
              date_reference: date_reference,
              suspected: sheet.cell(row, 3).to_i,
              confirmed: sheet.cell(row, 4).to_i,
              home_isolation: home_isolation_condiction,
              hospitalized: hospitalized_condiction,
              discarded: discarded_condiction,
              deaths: sheet.cell(row, 8).to_i,
              city_id: City.find_by(name: city_name_clean).id
            )
        end
      end

  end
end
