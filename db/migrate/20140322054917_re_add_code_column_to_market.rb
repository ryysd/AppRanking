class ReAddCodeColumnToMarket < ActiveRecord::Migration
  def change
      add_column :markets, :code, :string, :limit=>16, :null=>false
  end
end
