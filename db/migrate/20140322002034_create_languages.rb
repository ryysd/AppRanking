class CreateLanguages < ActiveRecord::Migration
    def change
	create_table "languages", force: true do |t|
	    t.string "name", limit: 64
	end

	add_index "languages", ["id"], name: "id_UNIQUE", unique: true, using: :btree
    end
end
