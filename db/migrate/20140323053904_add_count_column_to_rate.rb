class AddCountColumnToRate < ActiveRecord::Migration
  def change
    add_column :rates, :count, :integer
  end
end
