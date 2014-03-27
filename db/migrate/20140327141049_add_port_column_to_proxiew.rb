class AddPortColumnToProxiew < ActiveRecord::Migration
  def change
    add_column :proxies, :port, :string, :limit=>8, :null=>false
  end
end
