class AddSubCategoryColumnToAppItem < ActiveRecord::Migration
  def change
    add_column :app_items, :sub_category, :integer, :null => false
  end
end
