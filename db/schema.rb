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

ActiveRecord::Schema.define(version: 20141205222641) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "translations", id: false, force: true do |t|
    t.string   "token",       null: false
    t.integer  "priority",    null: false
    t.string   "rule_type"
    t.json     "rule_config"
    t.string   "target"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "translations", ["token", "priority"], name: "index_translations_on_token_and_priority", unique: true, using: :btree

end