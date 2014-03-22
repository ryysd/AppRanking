class AddIapColumnToAppItem < ActiveRecord::Migration
  def change
      add_column :app_items, :iap, :boolean, default: false
  end
end
