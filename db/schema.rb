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

ActiveRecord::Schema.define(version: 20140329221325) do

  create_table "companies", force: true do |t|
    t.string   "company_name"
    t.string   "permalink",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "companies", ["permalink"], name: "index_companies_on_permalink", unique: true, using: :btree

  create_table "contacts", force: true do |t|
    t.integer  "company_id"
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contacts", ["company_id"], name: "index_contacts_on_company_id", using: :btree

  create_table "conversations", force: true do |t|
    t.integer  "offer_id"
    t.integer  "company_id"
    t.string   "via",        default: "gmail", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "conversations", ["offer_id"], name: "index_conversations_on_offer_id", using: :btree

  create_table "conversations_loads", force: true do |t|
    t.integer "conversation_id"
    t.integer "loads"
    t.string  "container_size"
    t.string  "notes"
  end

  add_index "conversations_loads", ["conversation_id"], name: "index_conversations_loads_on_conversation_id", using: :btree

  create_table "conversations_others", force: true do |t|
    t.integer "conversation_id"
    t.text    "notes"
  end

  add_index "conversations_others", ["conversation_id"], name: "index_conversations_others_on_conversation_id", using: :btree

  create_table "conversations_packing_weights", force: true do |t|
    t.integer "conversation_id"
    t.integer "packing_weight_pounds"
    t.string  "container_size"
    t.string  "notes"
  end

  add_index "conversations_packing_weights", ["conversation_id"], name: "index_conversations_packing_weights_on_conversation_id", using: :btree

  create_table "conversations_pictures", force: true do |t|
    t.integer  "conversation_id"
    t.string   "notes"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
  end

  add_index "conversations_pictures", ["conversation_id"], name: "index_conversations_pictures_on_conversation_id", using: :btree

  create_table "conversations_prices", force: true do |t|
    t.integer "conversation_id"
    t.integer "place_id"
    t.decimal "usd_per_pound",   precision: 12, scale: 5,                 null: false
    t.string  "incoterm",                                 default: "EXW", null: false
    t.string  "notes"
  end

  add_index "conversations_prices", ["conversation_id"], name: "index_conversations_prices_on_conversation_id", using: :btree
  add_index "conversations_prices", ["place_id"], name: "index_conversations_prices_on_place_id", using: :btree

  create_table "conversations_weights", force: true do |t|
    t.integer "conversation_id"
    t.integer "total_weight_pounds"
    t.string  "notes"
  end

  add_index "conversations_weights", ["conversation_id"], name: "index_conversations_weights_on_conversation_id", using: :btree

  create_table "negotiations", force: true do |t|
    t.datetime "deleted_at"
    t.datetime "dead_at"
    t.datetime "finalized_at"
    t.datetime "completed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "offers", force: true do |t|
    t.string   "offer_type",     default: "sell", null: false
    t.integer  "company_id"
    t.integer  "negotiation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "offers", ["company_id"], name: "index_offers_on_company_id", using: :btree
  add_index "offers", ["negotiation_id"], name: "index_offers_on_negotiation_id", using: :btree

  create_table "places", force: true do |t|
    t.string   "name"
    t.string   "permalink"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "places", ["permalink"], name: "index_places_on_permalink", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
