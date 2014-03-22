class CreateFeeds < ActiveRecord::Migration
    def change
	create_table "feeds", force: true do |t|
	    t.integer "market_id",            null: false
	    t.string  "name",      limit: 32, null: false
	end

	add_index "feeds", ["id"], name: "id_UNIQUE", unique: true, using: :btree
	add_index "feeds", ["market_id"], name: "fk_feed_market1_idx", using: :btree
    end
end
