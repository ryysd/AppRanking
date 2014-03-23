class RenameDeviceHasApplicationsToApplicationsDevices < ActiveRecord::Migration
  def change
    rename_table :device_has_app_items, :app_items_devices
  end
end
