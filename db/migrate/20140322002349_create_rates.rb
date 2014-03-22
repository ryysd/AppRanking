class CreateRates < ActiveRecord::Migration
    def change
	create_table "rates", force: true do |t|
	    t.integer "value", null: false
	end

	add_index "rates", ["id"], name: "id_UNIQUE", unique: true, using: :btree
    end
end
