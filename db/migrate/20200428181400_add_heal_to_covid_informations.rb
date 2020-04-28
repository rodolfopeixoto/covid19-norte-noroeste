class AddHealToCovidInformations < ActiveRecord::Migration[6.0]
  def change
    add_column :covid_informations, :heal, :integer, default: 0
  end
end
