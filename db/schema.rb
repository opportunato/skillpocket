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

ActiveRecord::Schema.define(version: 20140730144114) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "poll_experts", force: true do |t|
    t.string "email"
    t.string "full_name"
    t.string "job"
    t.string "twitter_link"
    t.string "linkedin_link"
    t.string "site_link"
    t.string "skill_title"
    t.text   "skill_description"
    t.text   "tags"
    t.string "price"
    t.string "image"
    t.string "step"
    t.string "token"
  end

  create_table "pre_users", force: true do |t|
    t.string   "email"
    t.boolean  "is_read",    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end