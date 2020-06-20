class CreateInformation < ActiveRecord::Migration[6.0]
  def change
    create_table :information do |t|
      t.integer :suspected
      t.integer :confirmed
      t.integer :home_isolations
      t.integer :hospitalized
      t.integer :deaths
      t.integer :heal
      t.integer :discarded
      t.date :reference_at
      t.references :city, null: false, foreign_key: true

      t.timestamps
    end
  end
end
