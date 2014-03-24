class AddCodeColumnToFeed < ActiveRecord::Migration
  def change
      add_column :feeds, :code, :string, :limit => 32, :null => false
  end
end
