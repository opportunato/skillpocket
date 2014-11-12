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

ActiveRecord::Schema.define(version: 20141112173349) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

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
    t.integer  "older_id",   null: false
    t.integer  "newer_id",   null: false
    t.string   "body"
    t.datetime "updated_at"
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

  create_table "preapproved_handles", force: true do |t|
    t.string  "name"
    t.decimal "social_authority"
  end

  add_index "preapproved_handles", ["name"], name: "index_preapproved_handles_on_name", using: :btree

  create_table "skills", force: true do |t|
    t.integer  "price",         null: false
    t.string   "title",         null: false
    t.integer  "user_id",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "smartphone_os"
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

  create_table "user_friended_expert_followers", force: true do |t|
    t.integer  "user_id"
    t.integer  "expert_id"
    t.string   "twitter_id"
    t.string   "twitter_handle"
    t.string   "full_name"
    t.string   "photo_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_friended_expert_followers", ["expert_id"], name: "index_user_friended_expert_followers_on_expert_id", using: :btree
  add_index "user_friended_expert_followers", ["user_id"], name: "index_user_friended_expert_followers_on_user_id", using: :btree

  create_table "user_friended_experts", force: true do |t|
    t.integer  "user_id"
    t.integer  "expert_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_friended_experts", ["expert_id"], name: "index_user_friended_experts_on_expert_id", using: :btree
  add_index "user_friended_experts", ["user_id"], name: "index_user_friended_experts_on_user_id", using: :btree

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
    t.string   "role",                 default: "user"
    t.decimal  "social_authority"
    t.string   "ios_device_token"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "ip_address"
    t.boolean  "mailchimp_flag",       default: false
    t.integer  "max_search_distance",  default: 48
  end

  add_index "users", ["access_token"], name: "index_users_on_access_token", unique: true, using: :btree
  add_index "users", ["latitude", "longitude"], name: "index_users_on_latitude_and_longitude", using: :btree
  add_index "users", ["slug"], name: "index_users_on_slug", unique: true, using: :btree
  add_index "users", ["twitter_handle"], name: "index_users_on_twitter_handle", using: :btree
  add_index "users", ["twitter_token"], name: "index_users_on_twitter_token", unique: true, using: :btree

  add_foreign_key "conversations", "users", name: "conversations_newer_id_fk", column: "newer_id", dependent: :delete
  add_foreign_key "conversations", "users", name: "conversations_older_id_fk", column: "older_id", dependent: :delete

  add_foreign_key "messages", "conversations", name: "messages_conversation_id_fk", dependent: :delete
  add_foreign_key "messages", "users", name: "messages_recipient_id_fk", column: "recipient_id", dependent: :delete
  add_foreign_key "messages", "users", name: "messages_sender_id_fk", column: "sender_id", dependent: :delete

end
