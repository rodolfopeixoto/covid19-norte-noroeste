class CreateCovidInformations < ActiveRecord::Migration[6.0]
  def change
    create_table :covid_informations do |t|
      t.date :date_reference
      t.integer :suspected
      t.integer :confirmed
      t.integer :home_isolation
      t.integer :hospitalized
      t.integer :discarded
      t.integer :deaths
      t.references :city, null: false, foreign_key: true

      t.timestamps
    end
  end
end
