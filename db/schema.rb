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

  create_table "application", force: true do |t|
    t.integer  "ranking_id",                 null: false
    t.integer  "category_id",                null: false
    t.integer  "publisher_id",               null: false
    t.integer  "market_id",                  null: false
    t.string   "name",           limit: 256, null: false
    t.string   "icon",           limit: 256
    t.string   "version",        limit: 32
    t.datetime "release_date"
    t.datetime "last_updates"
    t.integer  "size"
    t.integer  "unified_app_id",             null: false
  end

  add_index "application", ["category_id"], name: "fk_application_category1_idx", using: :btree
  add_index "application", ["id"], name: "id_UNIQUE", unique: true, using: :btree
  add_index "application", ["market_id"], name: "fk_application_market1_idx", using: :btree
  add_index "application", ["publisher_id"], name: "fk_application_publisher1_idx", using: :btree
  add_index "application", ["ranking_id"], name: "fk_application_ranking_idx", using: :btree
  add_index "application", ["unified_app_id"], name: "fk_application_application1_idx", using: :btree

  create_table "category", force: true do |t|
    t.integer "parent_id",            null: false
    t.integer "market_id",            null: false
    t.string  "name",      limit: 32
  end

  add_index "category", ["id"], name: "id_UNIQUE", unique: true, using: :btree
  add_index "category", ["market_id"], name: "fk_category_market1_idx", using: :btree
  add_index "category", ["parent_id"], name: "fk_category_category1_idx", using: :btree

  create_table "country", force: true do |t|
    t.string "code", limit: 16,  null: false
    t.string "name", limit: 128, null: false
  end

  add_index "country", ["id"], name: "id_UNIQUE", unique: true, using: :btree

  create_table "currency", id: false, force: true do |t|
    t.integer "id",                     null: false
    t.integer "language_id",            null: false
    t.string  "name",        limit: 16, null: false
  end

  add_index "currency", ["id"], name: "id_UNIQUE", unique: true, using: :btree
  add_index "currency", ["language_id"], name: "fk_currency_language1_idx", using: :btree

  create_table "description", id: false, force: true do |t|
    t.integer "id",          null: false
    t.integer "national_id", null: false
    t.text    "text",        null: false
  end

  add_index "description", ["id"], name: "id_UNIQUE", unique: true, using: :btree
  add_index "description", ["national_id"], name: "fk_description_national1_idx", using: :btree

  create_table "device", force: true do |t|
    t.string "name", limit: 64
  end

  add_index "device", ["id"], name: "id_UNIQUE", unique: true, using: :btree

  create_table "device_has_application", id: false, force: true do |t|
    t.integer "device_id",      null: false
    t.integer "application_id", null: false
  end

  add_index "device_has_application", ["application_id"], name: "fk_device_has_application_application1_idx", using: :btree
  add_index "device_has_application", ["device_id"], name: "fk_device_has_application_device1_idx", using: :btree

  create_table "feed", id: false, force: true do |t|
    t.integer "id",                   null: false
    t.integer "market_id",            null: false
    t.string  "name",      limit: 32, null: false
  end

  add_index "feed", ["id"], name: "id_UNIQUE", unique: true, using: :btree
  add_index "feed", ["market_id"], name: "fk_feed_market1_idx", using: :btree

  create_table "language", force: true do |t|
    t.string "name", limit: 64
  end

  add_index "language", ["id"], name: "id_UNIQUE", unique: true, using: :btree

  create_table "market", force: true do |t|
    t.string "name", limit: 32, null: false
  end

  add_index "market", ["id"], name: "id_UNIQUE", unique: true, using: :btree

  create_table "national", force: true do |t|
    t.integer "application_id", null: false
    t.integer "language_id",    null: false
  end

  add_index "national", ["application_id"], name: "fk_language_application1_idx", using: :btree
  add_index "national", ["id"], name: "id_UNIQUE", unique: true, using: :btree
  add_index "national", ["language_id"], name: "fk_national_language1_idx", using: :btree

  create_table "price", force: true do |t|
    t.integer "national_id", null: false
    t.integer "value",       null: false
  end

  add_index "price", ["id"], name: "id_UNIQUE", unique: true, using: :btree
  add_index "price", ["national_id"], name: "fk_price_national1_idx", using: :btree

  create_table "publisher", force: true do |t|
    t.string "name", limit: 64, null: false
  end

  add_index "publisher", ["id"], name: "id_UNIQUE", unique: true, using: :btree

  create_table "ranking", force: true do |t|
    t.integer "feed_id",    null: false
    t.integer "country_id", null: false
    t.integer "market_id",  null: false
  end

  add_index "ranking", ["country_id"], name: "fk_ranking_country1_idx", using: :btree
  add_index "ranking", ["feed_id"], name: "fk_ranking_feed1_idx", using: :btree
  add_index "ranking", ["id"], name: "id_UNIQUE", unique: true, using: :btree
  add_index "ranking", ["market_id"], name: "fk_ranking_market1_idx", using: :btree

  create_table "rate", force: true do |t|
    t.integer "value", null: false
  end

  add_index "rate", ["id"], name: "id_UNIQUE", unique: true, using: :btree

  create_table "review", force: true do |t|
    t.integer "national_id", null: false
    t.text    "comment",     null: false
    t.integer "rate_id",     null: false
  end

  add_index "review", ["id"], name: "id_UNIQUE", unique: true, using: :btree
  add_index "review", ["national_id"], name: "fk_review_national1_idx", using: :btree
  add_index "review", ["rate_id"], name: "fk_review_rate1_idx", using: :btree

end
