class AddColumnToProxy < ActiveRecord::Migration
  def change
    add_column :proxies, :country_id, :integer, :null => false
    add_column :proxies, :ip_address, :string, :limit => 64, :null => false
  end
end
