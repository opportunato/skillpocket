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

ActiveRecord::Schema.define(version: 20141022120553) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "berlin_connects", force: true do |t|
    t.integer  "expert_id"
    t.string   "name"
    t.string   "email"
    t.text     "topic"
    t.string   "expert_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "conversations", force: true do |t|
    t.integer "older_id", null: false
    t.integer "newer_id", null: false
  end

  add_index "conversations", ["older_id", "newer_id"], name: "index_conversations_on_older_id_and_newer_id", unique: true, using: :btree

  create_table "messages", force: true do |t|
    t.integer  "sender_id",                       null: false
    t.integer  "recipient_id",                    null: false
    t.integer  "conversation_id",                 null: false
    t.boolean  "is_read",         default: false
    t.text     "body",                            null: false
    t.datetime "created_at",                      null: false
  end

  add_index "messages", ["conversation_id", "created_at"], name: "index_messages_on_conversation_id_and_created_at", using: :btree
  add_index "messages", ["conversation_id", "is_read", "created_at"], name: "index_messages_on_conversation_id_and_is_read_and_created_at", using: :btree
  add_index "messages", ["conversation_id", "is_read"], name: "index_messages_on_conversation_id_and_is_read", using: :btree

  create_table "poll_experts", force: true do |t|
    t.string   "email"
    t.string   "full_name"
    t.string   "job"
    t.string   "twitter_link"
    t.string   "linkedin_link"
    t.string   "site_link"
    t.string   "skill_title"
    t.text     "skill_description"
    t.text     "tags"
    t.string   "price"
    t.string   "image"
    t.string   "step"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "expert_created",    default: false
    t.text     "about"
    t.string   "color"
  end

  create_table "pre_users", force: true do |t|
    t.string   "email"
    t.boolean  "is_read",    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skills", force: true do |t|
    t.integer  "price",      null: false
    t.string   "title",      null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "skills", ["user_id"], name: "index_skills_on_user_id", using: :btree

  create_table "skills_tags", force: true do |t|
    t.integer  "skill_id",   null: false
    t.integer  "tag_id",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "skills_tags", ["skill_id"], name: "index_skills_tags_on_skill_id", using: :btree
  add_index "skills_tags", ["tag_id"], name: "index_skills_tags_on_tag_id", using: :btree

  create_table "tags", force: true do |t|
    t.string   "name"
    t.boolean  "is_category", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "job"
    t.text     "about"
    t.string   "photo"
    t.string   "profile_banner"
    t.string   "email"
    t.string   "slug"
    t.hstore   "urls",                 default: {}
    t.string   "access_token"
    t.string   "twitter_id"
    t.string   "twitter_token"
    t.string   "twitter_token_secret"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "full_name"
    t.string   "twitter_handle"
    t.boolean  "approved",             default: false
  end

  add_index "users", ["access_token"], name: "index_users_on_access_token", unique: true, using: :btree
  add_index "users", ["slug"], name: "index_users_on_slug", unique: true, using: :btree
  add_index "users", ["twitter_handle"], name: "index_users_on_twitter_handle", using: :btree
  add_index "users", ["twitter_token"], name: "index_users_on_twitter_token", unique: true, using: :btree

  add_foreign_key "conversations", "users", name: "conversations_newer_id_fk", column: "newer_id", dependent: :delete
  add_foreign_key "conversations", "users", name: "conversations_older_id_fk", column: "older_id", dependent: :delete

  add_foreign_key "messages", "conversations", name: "messages_conversation_id_fk", dependent: :delete
  add_foreign_key "messages", "users", name: "messages_recipient_id_fk", column: "recipient_id", dependent: :delete
  add_foreign_key "messages", "users", name: "messages_sender_id_fk", column: "sender_id", dependent: :delete

end
