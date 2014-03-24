class RemoveNationalTable < ActiveRecord::Migration
  def change
    add_column :descriptions, :app_item_id, :integer
    add_column :descriptions, :country_id, :integer

    add_column :prices, :app_item_id, :integer
    add_column :prices, :country_id, :integer
  end
end
