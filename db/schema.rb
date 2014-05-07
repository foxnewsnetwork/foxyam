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

ActiveRecord::Schema.define(version: 20140507180323) do

  create_table "attached_files_emails", force: true do |t|
    t.integer  "attached_file_id"
    t.integer  "email_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attached_files_emails", ["attached_file_id"], name: "index_attached_files_emails_on_attached_file_id", using: :btree
  add_index "attached_files_emails", ["email_id"], name: "index_attached_files_emails_on_email_id", using: :btree

  create_table "attached_files_pictures", force: true do |t|
    t.integer  "attached_file_id"
    t.integer  "picture_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attached_files_pictures", ["attached_file_id"], name: "index_attached_files_pictures_on_attached_file_id", using: :btree
  add_index "attached_files_pictures", ["picture_id"], name: "index_attached_files_pictures_on_picture_id", using: :btree

  create_table "companies", force: true do |t|
    t.string   "company_name"
    t.string   "permalink",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "merchant_id"
  end

  add_index "companies", ["merchant_id"], name: "index_companies_on_merchant_id", using: :btree
  add_index "companies", ["permalink"], name: "index_companies_on_permalink", unique: true, using: :btree

  create_table "contacts", force: true do |t|
    t.integer  "company_id"
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role"
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

  create_table "conversations_materials", force: true do |t|
    t.integer  "conversation_id"
    t.string   "material"
    t.string   "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "place_permalink"
  end

  add_index "conversations_materials", ["conversation_id"], name: "index_conversations_materials_on_conversation_id", using: :btree
  add_index "conversations_materials", ["place_permalink"], name: "index_conversations_materials_on_place_permalink", using: :btree

  create_table "conversations_others", force: true do |t|
    t.integer  "conversation_id"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "conversations_others", ["conversation_id"], name: "index_conversations_others_on_conversation_id", using: :btree

  create_table "conversations_packing_weights", force: true do |t|
    t.integer  "conversation_id"
    t.integer  "packing_weight_pounds"
    t.string   "container_size"
    t.string   "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "conversations_packing_weights", ["conversation_id"], name: "index_conversations_packing_weights_on_conversation_id", using: :btree

  create_table "conversations_pictures", force: true do |t|
    t.integer  "conversation_id"
    t.string   "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
  end

  add_index "conversations_pictures", ["conversation_id"], name: "index_conversations_pictures_on_conversation_id", using: :btree

  create_table "conversations_prices", force: true do |t|
    t.integer  "conversation_id"
    t.integer  "place_id"
    t.decimal  "usd_per_pound",   precision: 12, scale: 5,                 null: false
    t.string   "incoterm",                                 default: "EXW", null: false
    t.string   "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "conversations_prices", ["conversation_id"], name: "index_conversations_prices_on_conversation_id", using: :btree
  add_index "conversations_prices", ["place_id"], name: "index_conversations_prices_on_place_id", using: :btree

  create_table "conversations_quantities", force: true do |t|
    t.integer  "quantity",                             null: false
    t.string   "units",                                null: false
    t.string   "notes"
    t.string   "time_interval",   default: "one-time", null: false
    t.integer  "conversation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "conversations_quantities", ["conversation_id"], name: "index_conversations_quantities_on_conversation_id", using: :btree

  create_table "conversations_raw_logs", force: true do |t|
    t.integer  "conversation_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "conversations_raw_logs", ["conversation_id"], name: "index_conversations_raw_logs_on_conversation_id", using: :btree

  create_table "email_accounts", force: true do |t|
    t.integer  "merchant_id"
    t.string   "email_address"
    t.string   "unencrypted_password"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "last_mined_at"
  end

  add_index "email_accounts", ["email_address"], name: "index_email_accounts_on_email_address", unique: true, using: :btree
  add_index "email_accounts", ["merchant_id"], name: "index_email_accounts_on_merchant_id", using: :btree

  create_table "email_inboxes", force: true do |t|
    t.integer  "negotiation_id"
    t.string   "email_address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "email_inboxes", ["email_address"], name: "index_email_inboxes_on_email_address", using: :btree
  add_index "email_inboxes", ["negotiation_id"], name: "index_email_inboxes_on_negotiation_id", using: :btree

  create_table "emails", force: true do |t|
    t.integer  "conversation_id"
    t.integer  "email_inbox_id"
    t.string   "external_id"
    t.text     "plain_content"
    t.text     "html_content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "emails", ["conversation_id"], name: "index_emails_on_conversation_id", using: :btree
  add_index "emails", ["email_inbox_id"], name: "index_emails_on_email_inbox_id", using: :btree
  add_index "emails", ["external_id"], name: "index_emails_on_external_id", using: :btree

  create_table "envelopes", force: true do |t|
    t.integer  "email_id"
    t.string   "subject"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "envelopes", ["email_id"], name: "index_envelopes_on_email_id", using: :btree

  create_table "envelopes_origins", force: true do |t|
    t.integer  "envelope_id"
    t.string   "origin_type",        default: "from", null: false
    t.string   "email_address",                       null: false
    t.string   "email_presentation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "envelopes_origins", ["envelope_id"], name: "index_envelopes_origins_on_envelope_id", using: :btree

  create_table "fox_yam_attached_files", force: true do |t|
    t.string   "description"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "the_file_file_name"
    t.string   "the_file_content_type"
    t.integer  "the_file_file_size"
    t.datetime "the_file_updated_at"
  end

  create_table "merchants", force: true do |t|
    t.string   "name"
    t.string   "permalink"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "merchants", ["permalink"], name: "index_merchants_on_permalink", unique: true, using: :btree

  create_table "negotiations", force: true do |t|
    t.integer  "merchant_id"
    t.datetime "deleted_at"
    t.datetime "dead_at"
    t.datetime "finalized_at"
    t.datetime "completed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "public_at"
    t.string   "negotiation_type"
  end

  add_index "negotiations", ["merchant_id"], name: "index_negotiations_on_merchant_id", using: :btree

  create_table "offers", force: true do |t|
    t.string   "offer_type",     default: "sell", null: false
    t.integer  "company_id"
    t.integer  "negotiation_id"
    t.datetime "deleted_at"
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
    t.string   "permission_levels"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_merchants", force: true do |t|
    t.integer  "user_id"
    t.integer  "merchant_id"
    t.string   "clearance",   default: "employee", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users_merchants", ["merchant_id"], name: "index_users_merchants_on_merchant_id", using: :btree
  add_index "users_merchants", ["user_id"], name: "index_users_merchants_on_user_id", using: :btree

end
