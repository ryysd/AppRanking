class ReAddCodeColumnToCategory < ActiveRecord::Migration
  def change
      add_column :categories, :code, :string, :limit => 32, :null => false
  end
end
