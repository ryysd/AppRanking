class CreateDescriptions < ActiveRecord::Migration
    def change
	create_table "description", id: false, force: true do |t|
	    t.integer "id",          null: false
	    t.integer "national_id", null: false
	    t.text    "text",        null: false
	end

	add_index "description", ["id"], name: "id_UNIQUE", unique: true, using: :btree
	add_index "description", ["national_id"], name: "fk_description_national1_idx", using: :btree
    end
end
