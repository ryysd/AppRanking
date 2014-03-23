class RemoveMarketIdFromRanking < ActiveRecord::Migration
  def change
      remove_column :rankings, :market_id
  end
end
