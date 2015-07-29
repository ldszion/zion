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

ActiveRecord::Schema.define(version: 20150727163553) do

  create_table "emergency_contacts", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "phone",      limit: 255
    t.integer  "kinship",    limit: 4
    t.integer  "person_id",  limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "emergency_contacts", ["person_id"], name: "index_emergency_contacts_on_person_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.text     "description",    limit: 65535
    t.datetime "start_datetime"
    t.datetime "end_datetime"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "people", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "last_name",  limit: 255
    t.string   "nickname",   limit: 255
    t.string   "address",    limit: 255
    t.date     "birthday"
    t.integer  "gender",     limit: 4
    t.integer  "ward_id",    limit: 4
    t.boolean  "member",     limit: 1
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "people", ["ward_id"], name: "index_people_on_ward_id", using: :btree

  create_table "phones", force: :cascade do |t|
    t.string   "number",         limit: 255
    t.integer  "provider",       limit: 4
    t.integer  "phoneable_id",   limit: 4
    t.string   "phoneable_type", limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "phones", ["phoneable_type", "phoneable_id"], name: "index_phones_on_phoneable_type_and_phoneable_id", using: :btree

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

  create_table "profiles", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "key",        limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

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
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "profile_id",      limit: 4
    t.integer  "person_id",       limit: 4
    t.integer  "ward_id",         limit: 4
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["person_id"], name: "index_users_on_person_id", using: :btree
  add_index "users", ["profile_id"], name: "index_users_on_profile_id", using: :btree
  add_index "users", ["ward_id"], name: "index_users_on_ward_id", using: :btree

  create_table "wards", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "stake_id",   limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "wards", ["stake_id"], name: "index_wards_on_stake_id", using: :btree

  add_foreign_key "emergency_contacts", "people"
  add_foreign_key "people", "wards"
  add_foreign_key "stakes", "regions"
  add_foreign_key "users", "people"
  add_foreign_key "users", "profiles"
  add_foreign_key "users", "wards"
  add_foreign_key "wards", "stakes"
end
