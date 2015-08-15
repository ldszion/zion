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

ActiveRecord::Schema.define(version: 20150815160041) do

  create_table "accounts", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "last_name",  limit: 255
    t.string   "nickname",   limit: 255
    t.string   "address",    limit: 255
    t.date     "birthday"
    t.string   "gender",     limit: 255
    t.boolean  "member",     limit: 1
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "phone",      limit: 255
    t.integer  "user_id",    limit: 4
  end

  add_index "accounts", ["user_id"], name: "index_accounts_on_user_id", using: :btree

  create_table "emergency_contacts", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "phone",      limit: 255
    t.string   "kinship",    limit: 255
    t.integer  "account_id", limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "emergency_contacts", ["account_id"], name: "index_emergency_contacts_on_account_id", using: :btree

  create_table "enrollments", id: false, force: :cascade do |t|
    t.integer "user_id",  limit: 4, null: false
    t.integer "event_id", limit: 4, null: false
  end

  add_index "enrollments", ["event_id", "user_id"], name: "index_enrollments_on_event_id_and_user_id", unique: true, using: :btree
  add_index "enrollments", ["user_id", "event_id"], name: "index_enrollments_on_user_id_and_event_id", unique: true, using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.text     "description",    limit: 65535
    t.datetime "start_datetime"
    t.datetime "end_datetime"
    t.datetime "created_at",                                                        null: false
    t.datetime "updated_at",                                                        null: false
    t.decimal  "price",                        precision: 11, scale: 2
    t.integer  "private",        limit: 4,                              default: 0, null: false
  end

  create_table "pictures", force: :cascade do |t|
    t.integer  "imageable_id",       limit: 4
    t.string   "imageable_type",     limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
  end

  add_index "pictures", ["imageable_type", "imageable_id"], name: "index_pictures_on_imageable_type_and_imageable_id", using: :btree

  create_table "regions", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "stakes", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "region_id",  limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "stakes", ["region_id"], name: "index_stakes_on_region_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",           limit: 255
    t.string   "password_digest", limit: 255
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.integer  "ward_id",         limit: 4
    t.string   "profile",         limit: 255, default: "0"
    t.boolean  "leader",          limit: 1,   default: false
    t.boolean  "active",          limit: 1,   default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["ward_id"], name: "index_users_on_ward_id", using: :btree

  create_table "wards", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "stake_id",   limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "wards", ["stake_id"], name: "index_wards_on_stake_id", using: :btree

  add_foreign_key "accounts", "users"
  add_foreign_key "emergency_contacts", "accounts"
  add_foreign_key "stakes", "regions"
  add_foreign_key "users", "wards"
  add_foreign_key "wards", "stakes"
end
