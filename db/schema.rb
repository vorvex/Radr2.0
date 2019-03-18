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

ActiveRecord::Schema.define(version: 2019_03_18_075534) do

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
    t.string "yt-video"
    t.string "soundcloud"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
  end

  create_table "social_links", force: :cascade do |t|
    t.integer "location_id"
    t.integer "performer_id"
    t.string "channel"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tickets", force: :cascade do |t|
    t.integer "event_id"
    t.string "name"
    t.string "url"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
