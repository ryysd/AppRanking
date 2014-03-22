class ChangeColumnState < ActiveRecord::Migration
  def change
      change_column :categories, :category_id, :integer, :null => true
      change_column :categories, :name, :string, :null => false 

      remove_column :markets, :code
      remove_column :categories, :code

      change_column :devices, :name, :string, :null => false
      change_column :app_items, :app_item_id, :integer, :null => true

      change_column :languages, :name, :string, :null => false
      add_column :languages, :code, :string, :limit=>32, :null=>false
  end
end
