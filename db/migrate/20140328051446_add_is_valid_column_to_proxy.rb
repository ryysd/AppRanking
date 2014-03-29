class AddIsValidColumnToProxy < ActiveRecord::Migration
  def change
    add_column :proxies, :is_valid, :boolean, :default => true
  end
end
