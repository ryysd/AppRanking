class RemoveRankingIdFromAppItem < ActiveRecord::Migration
  def change
    remove_column :app_items, :ranking_id
  end
end
