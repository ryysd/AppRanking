class CreateCategories < ActiveRecord::Migration
    def change
	create_table "categories", force: true do |t|
	    t.integer "category_id",            null: false
	    t.integer "market_id",              null: false
	    t.string  "name",        limit: 32
	end

	add_index "categories", ["category_id"], name: "fk_category_category1_idx", using: :btree
	add_index "categories", ["id"], name: "id_UNIQUE", unique: true, using: :btree
	add_index "categories", ["market_id"], name: "fk_category_market1_idx", using: :btree
    end
end
