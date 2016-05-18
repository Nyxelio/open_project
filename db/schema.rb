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

ActiveRecord::Schema.define(version: 20160518124232) do

  create_table "activities", force: :cascade do |t|
    t.decimal  "num_hours"
    t.integer  "worker_id"
    t.integer  "task_id"
    t.text     "observation"
    t.date     "date_activity"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "activities", ["task_id"], name: "index_activities_on_task_id"
  add_index "activities", ["worker_id"], name: "index_activities_on_worker_id"

  create_table "families", force: :cascade do |t|
    t.string   "label"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.boolean  "is_close"
    t.date     "estimated_start_at"
    t.date     "estimated_end_at"
    t.decimal  "estimated_duration"
    t.date     "real_start_at"
    t.date     "real_end_at"
    t.decimal  "real_duration"
    t.decimal  "difference_hour"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "settings", force: :cascade do |t|
    t.string   "label"
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.string   "code"
    t.string   "label"
    t.date     "estimated_start_at"
    t.date     "estimated_end_at"
    t.decimal  "estimated_duration"
    t.date     "real_start_at"
    t.date     "real_end_at"
    t.decimal  "real_duration"
    t.decimal  "percent_progress"
    t.decimal  "ratio"
    t.integer  "project_id"
    t.integer  "family_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "tasks", ["family_id"], name: "index_tasks_on_family_id"
  add_index "tasks", ["project_id"], name: "index_tasks_on_project_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "workers", force: :cascade do |t|
    t.string   "name"
    t.decimal  "cost_hour"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
