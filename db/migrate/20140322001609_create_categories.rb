class CreateCategories < ActiveRecord::Migration
    def change
	create_table "category", force: true do |t|
	    t.integer "parent_id",            null: false
	    t.integer "market_id",            null: false
	    t.string  "name",      limit: 32
	end

	add_index "category", ["id"], name: "id_UNIQUE", unique: true, using: :btree
	add_index "category", ["market_id"], name: "fk_category_market1_idx", using: :btree
	add_index "category", ["parent_id"], name: "fk_category_category1_idx", using: :btree
    end
end
