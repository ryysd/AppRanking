class RemoveMarketIdFromAppItem < ActiveRecord::Migration
  def change
    remove_column :app_items, :market_id
  end
end
