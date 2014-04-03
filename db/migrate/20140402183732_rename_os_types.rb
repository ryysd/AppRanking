class RenameOsTypes < ActiveRecord::Migration
  def change
    rename_column :devices, :os_types, :os_type_id
  end
end
