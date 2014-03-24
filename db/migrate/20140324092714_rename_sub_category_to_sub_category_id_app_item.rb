class RenameSubCategoryToSubCategoryIdAppItem < ActiveRecord::Migration
  def change
    rename_column :app_items, :sub_category, :sub_category_id
  end
end
