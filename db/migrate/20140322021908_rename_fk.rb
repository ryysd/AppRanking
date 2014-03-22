class RenameFk < ActiveRecord::Migration
  def change
      rename_table :device_has_applications, :device_has_app_items
      rename_column :device_has_app_items, :application_id, :app_item_id
      rename_column :nationals, :application_id, :app_item_id
      rename_column :app_items, :application_id, :app_item_id
  end
end
