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

ActiveRecord::Schema.define(:version => 20120123182725) do

  create_table "badges", :force => true do |t|
    t.integer  "score"
    t.integer  "message_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role_id"
  end

  create_table "memberships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", :force => true do |t|
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "relation_properties", :force => true do |t|
    t.integer  "relation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "relations", :force => true do |t|
    t.integer  "parent_id"
    t.integer  "child_role_id"
    t.integer  "child_task_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "context"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "weight"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "xOffset"
    t.integer  "yOffset"
  end

  create_table "tasks", :force => true do |t|
    t.integer  "task_id"
    t.string   "name"
    t.boolean  "sod"
    t.integer  "weight"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "xOffset"
    t.integer  "yOffset"
  end

  create_table "translations", :force => true do |t|
    t.string   "text"
    t.string   "lang"
    t.integer  "message_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "foreign_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
