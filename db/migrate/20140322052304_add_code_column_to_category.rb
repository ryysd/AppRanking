class AddCodeColumnToCategory < ActiveRecord::Migration
  def change
      add_column :categories, :code, :string, :limit=>64
  end
end
