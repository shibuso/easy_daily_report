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

ActiveRecord::Schema.define(version: 20150923105049) do

  create_table "customers", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name",        limit: 255,                    null: false
    t.integer  "customer_id", limit: 4,                      null: false
    t.string   "status",      limit: 255, default: "active", null: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "projects", ["customer_id"], name: "index_projects_on_customer_id", using: :btree

  create_table "projects_users", force: :cascade do |t|
    t.integer  "project_id", limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "projects_users", ["project_id"], name: "index_projects_users_on_project_id", using: :btree
  add_index "projects_users", ["user_id"], name: "index_projects_users_on_user_id", using: :btree

  create_table "reports", force: :cascade do |t|
    t.integer  "user_id",     limit: 4,     null: false
    t.date     "target_date",               null: false
    t.text     "question",    limit: 65535
    t.text     "impression",  limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "reports", ["user_id"], name: "index_reports_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",                   limit: 255, default: "",       null: false
    t.string   "email",                  limit: 255, default: "",       null: false
    t.string   "encrypted_password",     limit: 255, default: "",       null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,        null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "user_type",              limit: 255, default: "member", null: false
    t.datetime "suspended_at"
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "works", force: :cascade do |t|
    t.integer  "report_id",  limit: 4,     null: false
    t.integer  "project_id", limit: 4,     null: false
    t.float    "time",       limit: 24
    t.text     "detail",     limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "works", ["project_id"], name: "index_works_on_project_id", using: :btree
  add_index "works", ["report_id"], name: "index_works_on_report_id", using: :btree

end
