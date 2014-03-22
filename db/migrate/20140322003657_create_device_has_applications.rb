class CreateDeviceHasApplications < ActiveRecord::Migration
    def change
	create_table "device_has_applications", force: true do |t|
	    t.integer "device_id",      null: false
	    t.integer "application_id", null: false
	end

	add_index "device_has_applications", ["application_id"], name: "fk_device_has_application_application1_idx", using: :btree
	add_index "device_has_applications", ["device_id"], name: "fk_device_has_application_device1_idx", using: :btree
    end
end
