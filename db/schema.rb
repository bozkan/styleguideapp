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

ActiveRecord::Schema.define(version: 2018_12_20_130637) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.integer "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "stripe_customer_id"
    t.index ["stripe_customer_id"], name: "index_accounts_on_stripe_customer_id", unique: true, where: "(stripe_customer_id IS NOT NULL)"
  end

  create_table "brands", force: :cascade do |t|
    t.bigint "account_id"
    t.string "name"
    t.string "subdomain"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "stylesheet_url"
    t.string "website"
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
    t.bigint "color_category_id"
    t.index ["brand_id"], name: "index_colors_on_brand_id"
    t.index ["color_category_id"], name: "index_colors_on_color_category_id"
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
    t.integer "weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "size"
    t.string "line_height"
    t.index ["brand_id"], name: "index_fonts_on_brand_id"
  end

  create_table "logos", force: :cascade do |t|
    t.bigint "brand_id"
    t.text "file_data"
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "display_color"
    t.index ["brand_id"], name: "index_logos_on_brand_id"
  end

  create_table "spacers", force: :cascade do |t|
    t.bigint "brand_id"
    t.integer "size", default: 4, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_id"], name: "index_spacers_on_brand_id"
  end

  create_table "subscription_payments", force: :cascade do |t|
    t.bigint "subscription_id"
    t.string "transaction_id"
    t.boolean "paid", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "amount_cents", default: 0, null: false
    t.string "amount_currency", default: "USD", null: false
    t.bigint "account_id"
    t.index ["account_id"], name: "index_subscription_payments_on_account_id"
    t.index ["subscription_id"], name: "index_subscription_payments_on_subscription_id"
    t.index ["transaction_id"], name: "index_subscription_payments_on_transaction_id", unique: true
  end

  create_table "subscription_plans", force: :cascade do |t|
    t.string "name", null: false
    t.string "stripe_id"
    t.integer "interval", default: 0
    t.integer "interval_count", default: 0
    t.integer "trial_period_days"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "amount_cents", default: 0, null: false
    t.string "amount_currency", default: "USD", null: false
    t.index ["stripe_id"], name: "index_subscription_plans_on_stripe_id", unique: true
  end

  create_table "subscriptions", force: :cascade do |t|
    t.bigint "subscription_plan_id"
    t.string "stripe_id"
    t.integer "status", default: 0
    t.datetime "expiration"
    t.bigint "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_subscriptions_on_account_id", unique: true
    t.index ["stripe_id"], name: "index_subscriptions_on_stripe_id", unique: true
    t.index ["subscription_plan_id"], name: "index_subscriptions_on_subscription_plan_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "webhook_events", force: :cascade do |t|
    t.string "webhook_id"
    t.datetime "api_version"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["webhook_id"], name: "index_webhook_events_on_webhook_id", unique: true
  end

  add_foreign_key "brands", "accounts"
  add_foreign_key "color_categories", "brands"
  add_foreign_key "colors", "brands"
  add_foreign_key "colors", "color_categories"
  add_foreign_key "components", "brands"
  add_foreign_key "fonts", "brands"
  add_foreign_key "logos", "brands"
  add_foreign_key "spacers", "brands"
  add_foreign_key "subscription_payments", "accounts"
  add_foreign_key "subscription_payments", "subscriptions"
  add_foreign_key "subscriptions", "accounts"
  add_foreign_key "subscriptions", "subscription_plans"
end
