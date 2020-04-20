class RenameCodeFromIbgeCoders < ActiveRecord::Migration[6.0]
  def up
    rename_column :cities, :code, :ibge_code
  end
  def down
    rename_column :cities, :ibge_code, :code
  end
end
