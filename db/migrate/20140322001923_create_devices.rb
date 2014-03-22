class CreateDevices < ActiveRecord::Migration
    def change
	create_table "device_has_application", id: false, force: true do |t|
	    t.integer "device_id",      null: false
	    t.integer "application_id", null: false
	end

	add_index "device_has_application", ["application_id"], name: "fk_device_has_application_application1_idx", using: :btree
	add_index "device_has_application", ["device_id"], name: "fk_device_has_application_device1_idx", using: :btree
    end
end
