class AddPositiveActiveToCovidInformations < ActiveRecord::Migration[6.0]
  def change
    add_column :covid_informations, :positive_active, :integer, default: 0
  end
end
