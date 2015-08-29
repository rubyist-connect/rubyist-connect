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

ActiveRecord::Schema.define(version: 20150829071509) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "event_participations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "event_participations", ["event_id"], name: "index_event_participations_on_event_id", using: :btree
  add_index "event_participations", ["user_id"], name: "index_event_participations_on_user_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                          limit: 255
    t.string   "image",                         limit: 255
    t.string   "email",                         limit: 255
    t.text     "introduction"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "github_id",                     limit: 255
    t.string   "twitter_name",                  limit: 255
    t.string   "github_url",                    limit: 255
    t.string   "facebook_name",                 limit: 255
    t.string   "nickname",                      limit: 255
    t.string   "location",                      limit: 255
    t.string   "blog",                          limit: 255
    t.integer  "sign_in_count",                             default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "qiita_name",                    limit: 255
    t.date     "birthday"
    t.datetime "profile_updated_at"
    t.boolean  "new_user_notification_enabled",             default: false, null: false
  end

  add_index "users", ["github_id"], name: "index_users_on_github_id", unique: true, using: :btree
  add_index "users", ["nickname"], name: "index_users_on_nickname", unique: true, using: :btree

end
