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

ActiveRecord::Schema.define(version: 20140918132709) do

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
    t.text     "description", null: false
    t.integer  "price",       null: false
    t.string   "title",       null: false
    t.integer  "user_id",     null: false
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
    t.string   "first_name",                        null: false
    t.string   "last_name",                         null: false
    t.string   "job"
    t.text     "about"
    t.string   "photo"
    t.string   "profile_banner"
    t.string   "email"
    t.string   "slug"
    t.hstore   "links",                default: {}
    t.string   "access_token"
    t.string   "twitter_id"
    t.string   "twitter_token"
    t.string   "twitter_token_secret"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["access_token"], name: "index_users_on_access_token", unique: true, using: :btree
  add_index "users", ["slug"], name: "index_users_on_slug", unique: true, using: :btree
  add_index "users", ["twitter_token"], name: "index_users_on_twitter_token", unique: true, using: :btree

end
