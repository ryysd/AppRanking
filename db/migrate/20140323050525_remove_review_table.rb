class RemoveReviewTable < ActiveRecord::Migration
  def change
    drop_table :reviews
    add_column :rates, :app_item_id, :integer
  end
end
