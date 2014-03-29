class RenameIpAddressColumnToHostColumn < ActiveRecord::Migration
  def change
    rename_column :proxies, :ip_address, :host
  end
end
