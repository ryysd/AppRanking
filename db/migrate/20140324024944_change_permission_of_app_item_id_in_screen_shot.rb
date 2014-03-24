class ChangePermissionOfAppItemIdInScreenShot < ActiveRecord::Migration
  def change
    change_column :screen_shots, :app_item_id, :integer, :null => false
  end
end
