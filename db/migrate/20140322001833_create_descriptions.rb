class CreateDescriptions < ActiveRecord::Migration
    def change
	create_table "descriptions", force: true do |t|
	    t.integer "national_id", null: false
	    t.text    "text",        null: false
	end

	add_index "descriptions", ["id"], name: "id_UNIQUE", unique: true, using: :btree
	add_index "descriptions", ["national_id"], name: "fk_description_national1_idx", using: :btree
    end
end
