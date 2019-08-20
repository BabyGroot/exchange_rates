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

ActiveRecord::Schema.define(version: 2019_08_20_215908) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "calculations", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "base_amount_subunit", null: false
    t.string "base_amount_currency", limit: 3, null: false
    t.integer "target_amount_subunit", null: false
    t.string "target_amount_currency", limit: 3, null: false
    t.float "exchange_rate", null: false
    t.date "date", null: false
    t.index ["user_id", "base_amount_currency", "date", "target_amount_currency"], name: "Idx UNIQUE on user_id, date, currencies", unique: true
  end

  create_table "exchange_rates", force: :cascade do |t|
    t.string "base_amount_currency", limit: 3, null: false
    t.string "target_amount_currency", limit: 3, null: false
    t.float "exchange_rate", null: false
    t.date "date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["base_amount_currency", "target_amount_currency", "date"], name: "Idx UNIQUE on exchange pair for date"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "google_token"
    t.string "google_refresh_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "hash_id"
  end

  create_table "widgets", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
