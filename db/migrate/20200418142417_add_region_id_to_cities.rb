class AddRegionIdToCities < ActiveRecord::Migration[6.0]
  def up
    add_reference :cities, :region, null: false, foreign_key: true, index: true
  end

  def remove
    remove_reference :cities, :region, null: false, foreign_key: true, index: true
  end
end
