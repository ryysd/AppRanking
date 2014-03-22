class CreateRankings < ActiveRecord::Migration
    def change
	create_table "rankings", force: true do |t|
	    t.integer  "feeds_id",        null: false
	    t.integer  "country_id",      null: false
	    t.integer  "market_id",       null: false
	    t.datetime "last_updated_on", null: false
	end

	add_index "rankings", ["country_id"], name: "fk_ranking_country1_idx", using: :btree
	add_index "rankings", ["feeds_id"], name: "fk_ranking_feed1_idx", using: :btree
	add_index "rankings", ["id"], name: "id_UNIQUE", unique: true, using: :btree
	add_index "rankings", ["market_id"], name: "fk_ranking_market1_idx", using: :btree
    end
end
