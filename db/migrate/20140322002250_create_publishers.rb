class CreatePublishers < ActiveRecord::Migration
    def change
	create_table "publishers", force: true do |t|
	    t.string "name", limit: 64, null: false
	end

	add_index "publishers", ["id"], name: "id_UNIQUE", unique: true, using: :btree
    end
end
