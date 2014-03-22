class CreateRankings < ActiveRecord::Migration
    def change
	create_table "ranking", force: true do |t|
	    t.integer "feed_id",    null: false
	    t.integer "country_id", null: false
	    t.integer "market_id",  null: false
	end

	add_index "ranking", ["country_id"], name: "fk_ranking_country1_idx", using: :btree
	add_index "ranking", ["feed_id"], name: "fk_ranking_feed1_idx", using: :btree
	add_index "ranking", ["id"], name: "id_UNIQUE", unique: true, using: :btree
	add_index "ranking", ["market_id"], name: "fk_ranking_market1_idx", using: :btree
    end
end
