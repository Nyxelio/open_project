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

ActiveRecord::Schema.define(version: 20160512093839) do

  create_table "activities", force: :cascade do |t|
    t.decimal  "num_hours"
    t.integer  "worker_id"
    t.integer  "task_id"
    t.text     "observation"
    t.datetime "date_activity"
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
    t.datetime "estimated_start_at"
    t.datetime "estimated_end_at"
    t.decimal  "estimated_duration"
    t.datetime "real_start_at"
    t.datetime "real_end_at"
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
    t.datetime "estimated_start_at"
    t.datetime "estimated_end_at"
    t.decimal  "estimated_duration"
    t.datetime "real_start_at"
    t.datetime "real_end_at"
    t.decimal  "real_duration"
    t.decimal  "percent_progress"
    t.decimal  "ratio"
    t.integer  "project_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "family_id"
  end

  add_index "tasks", ["project_id"], name: "index_tasks_on_project_id"

  create_table "workers", force: :cascade do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.decimal  "cost_hour"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
