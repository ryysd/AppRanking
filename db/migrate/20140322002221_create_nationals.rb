class CreateNationals < ActiveRecord::Migration
    def change
	create_table "national", force: true do |t|
	    t.integer "application_id", null: false
	    t.integer "language_id",    null: false
	end

	add_index "national", ["application_id"], name: "fk_language_application1_idx", using: :btree
	add_index "national", ["id"], name: "id_UNIQUE", unique: true, using: :btree
	add_index "national", ["language_id"], name: "fk_national_language1_idx", using: :btree
    end
end
