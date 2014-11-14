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

ActiveRecord::Schema.define(:version => 20140929130624) do

  create_table "admin_prices", :force => true do |t|
    t.string   "description"
    t.decimal  "price"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admin_users", :force => true do |t|
    t.string   "name"
    t.string   "login"
    t.string   "email"
    t.boolean  "follow_requests"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sequence_request_details", :force => true do |t|
    t.integer  "sequence_request_id"
    t.string   "sample_name"
    t.string   "adn_type_id"
    t.string   "oligo_id"
    t.string   "result"
    t.string   "commentaries"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "capilar"
  end

  create_table "sequence_requests", :force => true do |t|
    t.string   "company"
    t.string   "petitioner"
    t.string   "email"
    t.string   "phone"
    t.string   "group_leader"
    t.integer  "payment_method"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "folio"
    t.string   "status"
    t.datetime "status_change_at"
    t.integer  "admin_user_id"
    t.boolean  "inb_member"
    t.string   "results_file"
    t.integer  "ur_id",            :default => 0
  end

  create_table "urs", :force => true do |t|
    t.string   "name"
    t.string   "responsible"
    t.string   "mail"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

end
