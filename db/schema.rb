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

ActiveRecord::Schema.define(version: 20161213162624) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "subject_id"
    t.string   "subject_type"
    t.integer  "user_id"
    t.string   "action"
    t.string   "topic"
    t.string   "path"
    t.index ["subject_id"], name: "index_activities_on_subject_id", using: :btree
    t.index ["user_id"], name: "index_activities_on_user_id", using: :btree
  end

  create_table "chats", force: :cascade do |t|
    t.integer  "expedition_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "topic"
    t.integer  "creator_id"
    t.index ["creator_id"], name: "index_chats_on_creator_id", using: :btree
    t.index ["expedition_id"], name: "index_chats_on_expedition_id", using: :btree
  end

  create_table "coordinates", force: :cascade do |t|
    t.float    "latitude"
    t.float    "longitude"
    t.string   "location"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "expedition_id"
    t.boolean  "start_location"
    t.boolean  "end_location"
    t.index ["expedition_id"], name: "index_coordinates_on_expedition_id", using: :btree
  end

  create_table "expeditions", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "creator_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.boolean  "complete"
    t.string   "header"
    t.string   "name"
    t.text     "description"
    t.index ["creator_id"], name: "index_expeditions_on_creator_id", using: :btree
  end

  create_table "friendships", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
    t.integer  "friend_id"
    t.string   "status"
    t.datetime "accepted_at"
    t.index ["friend_id"], name: "index_friendships_on_friend_id", using: :btree
    t.index ["user_id"], name: "index_friendships_on_user_id", using: :btree
  end

  create_table "journeys", force: :cascade do |t|
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "user_id"
    t.integer  "expedition_id"
    t.string   "status"
    t.index ["expedition_id"], name: "index_journeys_on_expedition_id", using: :btree
    t.index ["user_id"], name: "index_journeys_on_user_id", using: :btree
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "chat_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "body"
    t.index ["chat_id"], name: "index_messages_on_chat_id", using: :btree
    t.index ["user_id"], name: "index_messages_on_user_id", using: :btree
  end

  create_table "profiles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "first_name"
    t.string   "last_name"
    t.text     "biography"
    t.string   "avatar"
    t.integer  "user_id"
    t.index ["user_id"], name: "index_profiles_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "username"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "fb_profile"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "activities", "users"
  add_foreign_key "chats", "expeditions"
  add_foreign_key "coordinates", "expeditions"
  add_foreign_key "friendships", "users"
  add_foreign_key "journeys", "expeditions"
  add_foreign_key "journeys", "users"
  add_foreign_key "messages", "chats"
  add_foreign_key "messages", "users"
  add_foreign_key "profiles", "users"
end
