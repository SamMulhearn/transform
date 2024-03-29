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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121019083022) do

  create_table "approvals", :force => true do |t|
    t.integer  "role_id",                       :null => false
    t.integer  "rfc_id",                        :null => false
    t.boolean  "closed",     :default => false, :null => false
    t.boolean  "approved",   :default => false, :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "assignments", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "role_id",    :null => false
    t.integer  "user_id",    :null => false
  end

  create_table "comments", :force => true do |t|
    t.integer  "rfc_id",     :null => false
    t.integer  "user_id"
    t.text     "comment"
    t.text     "css_class"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "rfcs", :force => true do |t|
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.integer  "user_id"
    t.string   "closure_code"
    t.string   "title"
    t.string   "status"
    t.text     "objective"
    t.text     "risk"
    t.text     "mitigate_risks"
    t.text     "backup"
    t.text     "impact"
    t.text     "imp_plan"
    t.text     "pre_task"
    t.text     "post_task"
    t.text     "backout_plan"
    t.date     "imp_date"
    t.boolean  "downtime",        :default => false
    t.time     "downtime_start"
    t.time     "downtime_finish"
  end

  add_index "rfcs", ["status"], :name => "index_rfcs_on_status"

  create_table "roles", :force => true do |t|
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.string   "name"
    t.boolean  "approvalgroup",  :default => true,  :null => false
    t.boolean  "mandatory_appr", :default => false, :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_token"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
