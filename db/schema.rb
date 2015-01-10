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

ActiveRecord::Schema.define(version: 20150110072024) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "event_participations", force: true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "event_participations", ["event_id"], name: "index_event_participations_on_event_id", using: :btree
  add_index "event_participations", ["user_id"], name: "index_event_participations_on_user_id", using: :btree

  create_table "events", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "interests", force: true do |t|
    t.integer  "user_id"
    t.string   "content"
    t.string   "content_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "image"
    t.string   "email"
    t.text     "introduction"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "github_id"
    t.string   "twitter_name"
    t.string   "github_url"
    t.string   "facebook_name"
    t.string   "nickname"
    t.string   "location"
    t.string   "blog"
    t.integer  "sign_in_count",      default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.date     "birthday"
    t.string   "qiita_name"
  end

  add_index "users", ["github_id"], name: "index_users_on_github_id", unique: true, using: :btree
  add_index "users", ["nickname"], name: "index_users_on_nickname", unique: true, using: :btree

end
