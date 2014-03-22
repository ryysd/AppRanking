class CreateRates < ActiveRecord::Migration
    def change
	create_table "rate", force: true do |t|
	    t.integer "value", null: false
	end

	add_index "rate", ["id"], name: "id_UNIQUE", unique: true, using: :btree
    end
end
