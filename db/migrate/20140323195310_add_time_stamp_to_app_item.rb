class AddTimeStampToAppItem < ActiveRecord::Migration
  def change
    add_column :app_items, :created_at, :datetime
    add_column :app_items, :updated_at, :datetime
  end
end
