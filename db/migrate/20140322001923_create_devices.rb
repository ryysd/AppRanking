class CreateDevices < ActiveRecord::Migration
    def change
	create_table "devices", force: true do |t|
	    t.string "name", limit: 64
	end

	add_index "devices", ["id"], name: "id_UNIQUE", unique: true, using: :btree
    end
end
