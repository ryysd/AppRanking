class CreateApplications < ActiveRecord::Migration
    def change
	create_table "applications", force: true do |t|
	    t.integer  "ranking_id",                  null: false
	    t.integer  "category_id",                 null: false
	    t.integer  "publisher_id",                null: false
	    t.integer  "market_id",                   null: false
	    t.integer  "application_id",              null: false
	    t.string   "name",            limit: 256, null: false
	    t.string   "icon",            limit: 256
	    t.string   "version",         limit: 32
	    t.datetime "released_on"
	    t.datetime "last_updated_on"
	    t.integer  "size"
	end

	add_index "applications", ["application_id"], name: "fk_application_application1_idx", using: :btree
	add_index "applications", ["category_id"], name: "fk_application_category1_idx", using: :btree
	add_index "applications", ["id"], name: "id_UNIQUE", unique: true, using: :btree
	add_index "applications", ["market_id"], name: "fk_application_market1_idx", using: :btree
	add_index "applications", ["publisher_id"], name: "fk_application_publisher1_idx", using: :btree
	add_index "applications", ["ranking_id"], name: "fk_application_ranking_idx", using: :btree
    end
end
