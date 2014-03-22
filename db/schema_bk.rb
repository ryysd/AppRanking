# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 0) do

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

  create_table "categories", force: true do |t|
    t.integer "category_id",            null: false
    t.integer "market_id",              null: false
    t.string  "name",        limit: 32
  end

  add_index "categories", ["category_id"], name: "fk_category_category1_idx", using: :btree
  add_index "categories", ["id"], name: "id_UNIQUE", unique: true, using: :btree
  add_index "categories", ["market_id"], name: "fk_category_market1_idx", using: :btree

  create_table "countries", force: true do |t|
    t.string "code", limit: 16,  null: false
    t.string "name", limit: 128, null: false
  end

  add_index "countries", ["id"], name: "id_UNIQUE", unique: true, using: :btree

  create_table "currencies", force: true do |t|
    t.integer "language_id",            null: false
    t.string  "name",        limit: 16, null: false
  end

  add_index "currencies", ["id"], name: "id_UNIQUE", unique: true, using: :btree
  add_index "currencies", ["language_id"], name: "fk_currency_language1_idx", using: :btree

  create_table "descriptions", force: true do |t|
    t.integer "national_id", null: false
    t.text    "text",        null: false
  end

  add_index "descriptions", ["id"], name: "id_UNIQUE", unique: true, using: :btree
  add_index "descriptions", ["national_id"], name: "fk_description_national1_idx", using: :btree

  create_table "device_has_applications", force: true do |t|
    t.integer "device_id",      null: false
    t.integer "application_id", null: false
  end

  add_index "device_has_applications", ["application_id"], name: "fk_device_has_application_application1_idx", using: :btree
  add_index "device_has_applications", ["device_id"], name: "fk_device_has_application_device1_idx", using: :btree

  create_table "devices", force: true do |t|
    t.string "name", limit: 64
  end

  add_index "devices", ["id"], name: "id_UNIQUE", unique: true, using: :btree

  create_table "feeds", force: true do |t|
    t.integer "market_id",            null: false
    t.string  "name",      limit: 32, null: false
  end

  add_index "feeds", ["id"], name: "id_UNIQUE", unique: true, using: :btree
  add_index "feeds", ["market_id"], name: "fk_feed_market1_idx", using: :btree

  create_table "languages", force: true do |t|
    t.string "name", limit: 64
  end

  add_index "languages", ["id"], name: "id_UNIQUE", unique: true, using: :btree

  create_table "markets", force: true do |t|
    t.string "name", limit: 32, null: false
  end

  add_index "markets", ["id"], name: "id_UNIQUE", unique: true, using: :btree

  create_table "nationals", force: true do |t|
    t.integer "application_id", null: false
    t.integer "language_id",    null: false
  end

  add_index "nationals", ["application_id"], name: "fk_language_application1_idx", using: :btree
  add_index "nationals", ["id"], name: "id_UNIQUE", unique: true, using: :btree
  add_index "nationals", ["language_id"], name: "fk_national_language1_idx", using: :btree

  create_table "prices", force: true do |t|
    t.integer "national_id", null: false
    t.integer "value",       null: false
  end

  add_index "prices", ["id"], name: "id_UNIQUE", unique: true, using: :btree
  add_index "prices", ["national_id"], name: "fk_price_national1_idx", using: :btree

  create_table "publishers", force: true do |t|
    t.string "name", limit: 64, null: false
  end

  add_index "publishers", ["id"], name: "id_UNIQUE", unique: true, using: :btree

  create_table "rankings", force: true do |t|
    t.integer  "feeds_id",        null: false
    t.integer  "country_id",      null: false
    t.integer  "market_id",       null: false
    t.datetime "last_updated_on", null: false
  end

  add_index "rankings", ["country_id"], name: "fk_ranking_country1_idx", using: :btree
  add_index "rankings", ["feeds_id"], name: "fk_ranking_feed1_idx", using: :btree
  add_index "rankings", ["id"], name: "id_UNIQUE", unique: true, using: :btree
  add_index "rankings", ["market_id"], name: "fk_ranking_market1_idx", using: :btree

  create_table "rates", force: true do |t|
    t.integer "value", null: false
  end

  add_index "rates", ["id"], name: "id_UNIQUE", unique: true, using: :btree

  create_table "reviews", force: true do |t|
    t.integer "national_id", null: false
    t.integer "rate_id",     null: false
    t.text    "comment",     null: false
  end

  add_index "reviews", ["id"], name: "id_UNIQUE", unique: true, using: :btree
  add_index "reviews", ["national_id"], name: "fk_review_national1_idx", using: :btree
  add_index "reviews", ["rate_id"], name: "fk_review_rate1_idx", using: :btree

end
