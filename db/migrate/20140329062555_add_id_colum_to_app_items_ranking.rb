class AddIdColumToAppItemsRanking < ActiveRecord::Migration
  def change
    remove_column :app_items_rankings, :created_at
    remove_column :app_items_rankings, :updated_at

    add_column :app_items_rankings, :app_item_id, :integer, :null => false
    add_column :app_items_rankings, :ranking_id, :integer, :null => false
  end
end
