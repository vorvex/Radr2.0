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

ActiveRecord::Schema.define(version: 2019_04_07_111024) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "events", force: :cascade do |t|
    t.integer "location_id"
    t.integer "performer_id"
    t.string "name"
    t.string "category"
    t.string "description"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string "pathname", default: "/"
    t.string "facebook_event"
    t.string "image_url"
    t.string "start_date"
    t.string "end_date"
    t.string "yt_video"
    t.string "soundcloud"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "path"
    t.integer "user_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.integer "user_id"
    t.string "url"
    t.string "pdf"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date"
    t.integer "amount_due"
    t.integer "amount_paid"
  end

  create_table "locations", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "name"
    t.string "category"
    t.string "formatted_address"
    t.string "route"
    t.string "street_number"
    t.string "postal_code"
    t.string "locality"
    t.string "place_id"
    t.float "lat"
    t.float "lng"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.string "path"
  end

  create_table "opening_hours", force: :cascade do |t|
    t.integer "location_id"
    t.date "date"
    t.integer "week_day"
    t.string "start_time"
    t.string "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "performers", force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.string "email"
    t.string "path"
  end

  create_table "social_links", force: :cascade do |t|
    t.integer "location_id"
    t.integer "performer_id"
    t.string "channel"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "event_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.integer "event_id"
    t.string "name"
    t.string "url"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "price"
    t.text "description"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "plan", default: "free", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cc_name"
    t.string "cc_exp_year"
    t.string "cc_exp_month"
    t.string "cc_last_four"
    t.string "cc_brand"
    t.string "cc_fingerprint"
    t.string "subscription_id"
    t.string "customer_id"
    t.boolean "onboarding"
    t.boolean "locked", default: false
    t.date "paid_for_till"
    t.boolean "bill_per_email", default: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
