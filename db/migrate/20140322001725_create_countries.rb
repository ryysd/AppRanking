class CreateCountries < ActiveRecord::Migration
    def change
	create_table "country", force: true do |t|
	    t.string "code", limit: 16,  null: false
	    t.string "name", limit: 128, null: false
	end

	add_index "country", ["id"], name: "id_UNIQUE", unique: true, using: :btree
    end
end
