class AddMarketIdToPublisher < ActiveRecord::Migration
  def change
    add_column :publishers, :market_id, :integer
  end
end
