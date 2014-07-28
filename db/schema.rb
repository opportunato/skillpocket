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

ActiveRecord::Schema.define(version: 20140728151507) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "poll_experts", force: true do |t|
    t.string "twitter_link"
    t.string "linkedin_link"
    t.string "site_link"
    t.text   "text_title"
    t.text   "tags"
    t.string "price"
    t.string "image"
  end

  create_table "skills", force: true do |t|
    t.string   "color",       limit: 6, null: false
    t.text     "description",           null: false
    t.integer  "price",                 null: false
    t.string   "title",                 null: false
    t.integer  "user_id",               null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "skills", ["user_id"], name: "index_skills_on_user_id", using: :btree

  create_table "temp_images", force: true do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "facebook_id", null: false
    t.string   "first_name",  null: false
    t.string   "last_name",   null: false
    t.string   "job"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "users", ["facebook_id"], name: "index_users_on_facebook_id", using: :btree

end
