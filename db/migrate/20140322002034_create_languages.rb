class CreateLanguages < ActiveRecord::Migration
    def change
	create_table "language", force: true do |t|
	    t.string "name", limit: 64
	end

	add_index "language", ["id"], name: "id_UNIQUE", unique: true, using: :btree
    end
end
