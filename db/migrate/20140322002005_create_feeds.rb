class CreateFeeds < ActiveRecord::Migration
    def change
	create_table "feed", id: false, force: true do |t|
	    t.integer "id",                   null: false
	    t.integer "market_id",            null: false
	    t.string  "name",      limit: 32, null: false
	end

	add_index "feed", ["id"], name: "id_UNIQUE", unique: true, using: :btree
	add_index "feed", ["market_id"], name: "fk_feed_market1_idx", using: :btree
    end
end
