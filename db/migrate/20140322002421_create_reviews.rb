class CreateReviews < ActiveRecord::Migration
    def change
	create_table "reviews", force: true do |t|
	    t.integer "national_id", null: false
	    t.integer "rate_id",     null: false
	    t.text    "comment",     null: false
	end

	add_index "reviews", ["id"], name: "id_UNIQUE", unique: true, using: :btree
	add_index "reviews", ["national_id"], name: "fk_review_national1_idx", using: :btree
	add_index "reviews", ["rate_id"], name: "fk_review_rate1_idx", using: :btree
    end
end
