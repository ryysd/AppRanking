class CreateCurrencies < ActiveRecord::Migration
    def change
	create_table "currencies", force: true do |t|
	    t.integer "language_id",            null: false
	    t.string  "name",        limit: 16, null: false
	end

	add_index "currencies", ["id"], name: "id_UNIQUE", unique: true, using: :btree
	add_index "currencies", ["language_id"], name: "fk_currency_language1_idx", using: :btree
    end
end
