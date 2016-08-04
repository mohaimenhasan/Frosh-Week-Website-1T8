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

ActiveRecord::Schema.define(:version => 20160804163800) do

  create_table "admins", :force => true do |t|
    t.string   "email"
    t.text     "authorized_routes"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.string   "symbol"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "facebook_link"
  end

  create_table "hhf_package_items", :force => true do |t|
    t.string   "name"
    t.string   "key"
    t.text     "description"
    t.integer  "price"
    t.integer  "count"
    t.integer  "max"
    t.integer  "left"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "hhf_packages", :force => true do |t|
    t.string   "name"
    t.string   "key"
    t.integer  "price"
    t.integer  "fweekbus",   :default => 0
    t.integer  "leedurbus",  :default => 0
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "leedurs", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "year"
    t.string   "discipline"
    t.string   "gender"
    t.string   "phone"
    t.string   "confirmation_token"
    t.boolean  "verified"
    t.string   "emergency_name"
    t.string   "emergency_phone"
    t.string   "emergency_relationship"
    t.string   "emergency_email"
    t.text     "restrictions_dietary"
    t.text     "restrictions_misc"
    t.string   "charge_id"
    t.string   "ticket_number"
    t.integer  "hhf_package_id"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "created_by_admin"
    t.boolean  "checked_in",             :default => false
    t.boolean  "leedurbus",              :default => false
    t.boolean  "fweekbus",               :default => false
    t.string   "email"
    t.boolean  "tent",                   :default => false
  end

  create_table "package_items", :force => true do |t|
    t.string   "key"
    t.string   "name"
    t.text     "description"
    t.integer  "price"
    t.integer  "count"
    t.integer  "max"
    t.integer  "left"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "packages", :force => true do |t|
    t.string   "name"
    t.string   "key"
    t.integer  "price"
    t.integer  "count"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "photos", :force => true do |t|
    t.string   "event"
    t.string   "link"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
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
    t.boolean  "bursary_requested"
    t.boolean  "bursary_chosen"
    t.boolean  "bursary_paid"
    t.text     "bursary_engineering_motivation"
    t.text     "bursary_financial_reasoning"
    t.boolean  "bursary_osap"
    t.string   "confirmation_token"
    t.boolean  "verified"
    t.string   "emergency_name"
    t.string   "emergency_phone"
    t.string   "emergency_relationship"
    t.string   "emergency_email"
    t.text     "restrictions_dietary"
    t.text     "restrictions_accessibility"
    t.text     "restrictions_misc"
    t.string   "charge_id"
    t.string   "ticket_number"
    t.integer  "group_id"
    t.integer  "package_id"
    t.datetime "created_at",                                        :null => false
    t.datetime "updated_at",                                        :null => false
    t.string   "created_by_admin"
    t.boolean  "checked_in",                     :default => false
    t.boolean  "photo_consent",                  :default => false
    t.boolean  "tent",                           :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
