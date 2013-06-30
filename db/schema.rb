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

ActiveRecord::Schema.define(:version => 20130628053938) do

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "packages", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "price"
    t.integer  "count"
    t.integer  "max"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "discipline"
    t.string   "email"
    t.string   "gender"
    t.string   "shirt_size"
    t.string   "phone"
    t.string   "residence"
    t.integer  "package_id"
    t.boolean  "bursary_requested"
    t.boolean  "bursary_chosen"
    t.string   "confirmation_token"
    t.boolean  "verified"
    t.string   "emergency_name"
    t.string   "emergency_phone"
    t.string   "emergency_relationship"
    t.string   "emergency_email"
    t.text     "restrictions_dietary"
    t.text     "restrictions_accessibility"
    t.text     "restrictions_misc"
    t.integer  "group_id"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

end
