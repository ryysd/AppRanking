class AddLocalIdColumnToAppItem < ActiveRecord::Migration
  def change
    add_column :app_items, :local_id, :string, :limit=>128
  end
end
