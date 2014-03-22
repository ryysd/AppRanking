class CreatePrices < ActiveRecord::Migration
    def change
	create_table "price", force: true do |t|
	    t.integer "national_id", null: false
	    t.integer "value",       null: false
	end

	add_index "price", ["id"], name: "id_UNIQUE", unique: true, using: :btree
	add_index "price", ["national_id"], name: "fk_price_national1_idx", using: :btree
    end
end
