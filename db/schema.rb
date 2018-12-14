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

ActiveRecord::Schema.define(version: 2018_12_14_155913) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.integer "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "brands", force: :cascade do |t|
    t.bigint "account_id"
    t.string "name"
    t.string "subdomain"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_brands_on_account_id"
    t.index ["subdomain"], name: "index_brands_on_subdomain", unique: true
  end

  create_table "color_categories", force: :cascade do |t|
    t.bigint "brand_id"
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_id"], name: "index_color_categories_on_brand_id"
  end

  create_table "colors", force: :cascade do |t|
    t.bigint "brand_id"
    t.string "hex", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_id"], name: "index_colors_on_brand_id"
  end

  create_table "components", force: :cascade do |t|
    t.bigint "brand_id"
    t.string "name"
    t.text "description"
    t.text "markup"
    t.text "style"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_id"], name: "index_components_on_brand_id"
  end

  create_table "fonts", force: :cascade do |t|
    t.bigint "brand_id"
    t.string "name"
    t.decimal "size"
    t.decimal "line_height"
    t.integer "weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_id"], name: "index_fonts_on_brand_id"
  end

  create_table "logos", force: :cascade do |t|
    t.bigint "brand_id"
    t.text "file_data"
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_id"], name: "index_logos_on_brand_id"
  end

  create_table "spacers", force: :cascade do |t|
    t.bigint "brand_id"
    t.integer "size", default: 4, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_id"], name: "index_spacers_on_brand_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "brands", "accounts"
  add_foreign_key "color_categories", "brands"
  add_foreign_key "colors", "brands"
  add_foreign_key "components", "brands"
  add_foreign_key "fonts", "brands"
  add_foreign_key "logos", "brands"
  add_foreign_key "spacers", "brands"
end
