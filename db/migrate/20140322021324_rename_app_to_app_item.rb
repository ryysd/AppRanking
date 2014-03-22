class RenameAppToAppItem < ActiveRecord::Migration
  def change
      rename_table :apps, :app_items 
  end
end
