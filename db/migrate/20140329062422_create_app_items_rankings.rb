class CreateAppItemsRankings < ActiveRecord::Migration
  def change
    create_table :app_items_rankings do |t|

      t.timestamps
    end
  end
end
