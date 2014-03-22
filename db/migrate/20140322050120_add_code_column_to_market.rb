class AddCodeColumnToMarket < ActiveRecord::Migration
  def change
      add_column :markets, :code, :string, :limit=>16
  end
end
