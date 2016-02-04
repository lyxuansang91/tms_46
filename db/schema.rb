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

ActiveRecord::Schema.define(version: 20160205025110) do

  create_table "activities", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "target",     limit: 255
    t.string   "user_name",  limit: 255
    t.integer  "type",       limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "course_subject_tasks", force: :cascade do |t|
    t.integer "course_subject_id", limit: 4
    t.integer "task_id",           limit: 4
  end

  create_table "course_subjects", force: :cascade do |t|
    t.integer  "course_id",  limit: 4
    t.integer  "subject_id", limit: 4
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "status",     limit: 4, default: 0
  end

  create_table "courses", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "instruction", limit: 65535
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "status",      limit: 4,     default: 0
  end

  create_table "subjects", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "instruction", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "subject_id", limit: 4
  end

  create_table "user_courses", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "course_id",  limit: 4
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "status",     limit: 4, default: 0
  end

  create_table "user_subjects", force: :cascade do |t|
    t.integer  "user_id",           limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "status",            limit: 4
    t.integer  "course_subject_id", limit: 4
  end

  create_table "user_tasks", force: :cascade do |t|
    t.integer  "user_id",                limit: 4
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.integer  "course_subject_task_id", limit: 4
    t.integer  "status",                 limit: 4, default: 0
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",               limit: 255, default: "", null: false
    t.string   "encrypted_password",  limit: 255, default: "", null: false
    t.string   "name",                limit: 255, default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.integer  "role",                limit: 4,   default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
