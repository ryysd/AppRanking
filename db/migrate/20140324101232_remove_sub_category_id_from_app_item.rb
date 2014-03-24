class RemoveSubCategoryIdFromAppItem < ActiveRecord::Migration
  def change
    remove_column :app_items, :sub_category_id
  end
end
