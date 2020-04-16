require 'roo'
namespace :data_marco do
  task create: :environment do
      City.create(name: 'Campos dos Goytacazes', code: '3301009')
      City.create(name: 'Carapebus', code: '3300936')
      City.create(name: 'Cardoso Moreira', code: '3301157')
      City.create(name: 'Conceição de Macabu', code: '3301405')
      City.create(name: 'Macaé', code: '3302403')
      City.create(name: 'Quissamã', code: '3304151')
      City.create(name: 'São Fidélis', code: '3304805')
      City.create(name: 'São Francisco de Itabapoana', code: '3304755')
      City.create(name: 'São João da Barra', code: '3305000')
      path = Rails.root.join('lib', 'tasks', 'marco.xlsx').to_s
      xlsx = Roo::Spreadsheet.open(path)

      xlsx.sheets.each do |sheet_name|
        sheet = xlsx.sheet(sheet_name)
        last_row    = sheet.last_row
        last_column = sheet.last_column

        for row in 2..last_row
            # puts "["+row.to_s+","+col.to_s+"]: " + sheet.cell(row, col).to_s
            CovidInformation.create(
              date_reference: sheet.cell(row, 9).to_date,
              suspected: sheet.cell(row, 3).to_i,
              confirmed: sheet.cell(row, 4).to_i,
              home_isolation: sheet.cell(row, 5).to_i,
              hospitalized: sheet.cell(row, 6).to_i,
              discarded: sheet.cell(row, 7).to_i,
              deaths: sheet.cell(row, 8).to_i,
              city_id: City.find_by(name: sheet.cell(row, 2).sub(/\A[^\w\s]+/,'')).id
            )
        end
      end

  end
end
