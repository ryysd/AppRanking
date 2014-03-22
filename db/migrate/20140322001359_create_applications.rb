class CreateApplications < ActiveRecord::Migration
    def change
	create_table "application", force: true do |t|
	    t.integer  "ranking_id",                 null: false
	    t.integer  "category_id",                null: false
	    t.integer  "publisher_id",               null: false
	    t.integer  "market_id",                  null: false
	    t.string   "name",           limit: 256, null: false
	    t.string   "icon",           limit: 256
	    t.string   "version",        limit: 32
	    t.datetime "release_date"
	    t.datetime "last_updates"
	    t.integer  "size"
	    t.integer  "unified_app_id",             null: false
	end

	add_index "application", ["category_id"], name: "fk_application_category1_idx", using: :btree
	add_index "application", ["id"], name: "id_UNIQUE", unique: true, using: :btree
	add_index "application", ["market_id"], name: "fk_application_market1_idx", using: :btree
	add_index "application", ["publisher_id"], name: "fk_application_publisher1_idx", using: :btree
	add_index "application", ["ranking_id"], name: "fk_application_ranking_idx", using: :btree
	add_index "application", ["unified_app_id"], name: "fk_application_application1_idx", using: :btree
    end
end
