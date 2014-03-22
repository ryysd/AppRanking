class CreatePublishers < ActiveRecord::Migration
    def change
	create_table "publisher", force: true do |t|
	    t.string "name", limit: 64, null: false
	end

	add_index "publisher", ["id"], name: "id_UNIQUE", unique: true, using: :btree
    end
end
