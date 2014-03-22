class CreateCurrencies < ActiveRecord::Migration
    def change
	create_table "currency", id: false, force: true do |t|
	    t.integer "id",                     null: false
	    t.integer "language_id",            null: false
	    t.string  "name",        limit: 16, null: false
	end

	add_index "currency", ["id"], name: "id_UNIQUE", unique: true, using: :btree
	add_index "currency", ["language_id"], name: "fk_currency_language1_idx", using: :btree
    end
end
