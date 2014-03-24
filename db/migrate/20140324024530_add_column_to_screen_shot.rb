class AddColumnToScreenShot < ActiveRecord::Migration
  def change
    add_column :screen_shots, :app_item_id, :integer, :null => false
    add_column :screen_shots, :width, :integer, :null => true
    add_column :screen_shots, :height, :integer, :null => true
    add_column :screen_shots, :url, :string, :limit => 128, :null => false
    remove_column :screen_shots, :created_at
    remove_column :screen_shots, :updated_at
  end
end
