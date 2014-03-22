class CreateMarkets < ActiveRecord::Migration
    def change
	create_table "markets", force: true do |t|
	    t.string "name", limit: 32, null: false
	end

	add_index "markets", ["id"], name: "id_UNIQUE", unique: true, using: :btree
    end
end
