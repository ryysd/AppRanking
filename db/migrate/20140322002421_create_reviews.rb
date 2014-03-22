class CreateReviews < ActiveRecord::Migration
    def change
	create_table "review", force: true do |t|
	    t.integer "national_id", null: false
	    t.text    "comment",     null: false
	    t.integer "rate_id",     null: false
	end

	add_index "review", ["id"], name: "id_UNIQUE", unique: true, using: :btree
	add_index "review", ["national_id"], name: "fk_review_national1_idx", using: :btree
	add_index "review", ["rate_id"], name: "fk_review_rate1_idx", using: :btree
    end
end
