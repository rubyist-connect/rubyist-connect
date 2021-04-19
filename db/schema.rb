# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_10_11_033740) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "event_participations", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["event_id"], name: "index_event_participations_on_event_id"
    t.index ["user_id"], name: "index_event_participations_on_user_id"
  end

  create_table "events", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "url"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "image"
    t.string "email"
    t.text "introduction"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "github_id"
    t.string "twitter_name"
    t.string "github_url"
    t.string "facebook_name"
    t.string "nickname"
    t.string "location"
    t.string "blog"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.date "birthday"
    t.string "qiita_name"
    t.datetime "profile_updated_at"
    t.boolean "new_user_notification_enabled", default: false, null: false
    t.datetime "first_active_at"
    t.index ["github_id"], name: "index_users_on_github_id", unique: true
    t.index ["nickname"], name: "index_users_on_nickname", unique: true
  end

end
