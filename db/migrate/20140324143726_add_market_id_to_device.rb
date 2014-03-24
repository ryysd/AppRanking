class AddMarketIdToDevice < ActiveRecord::Migration
  def change
    add_column :devices, :market_id, :integer, :null => false
  end
end
