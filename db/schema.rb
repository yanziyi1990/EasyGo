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

ActiveRecord::Schema.define(version: 20170613201426) do

  create_table "gifts", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.string   "store_name",     limit: 255
    t.string   "price",          limit: 255
    t.string   "msrp",           limit: 255
    t.string   "store_category", limit: 255
    t.string   "colors",         limit: 2014
    t.string   "sizes",          limit: 1024
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "visited"
  end

  create_table "group_members", force: :cascade do |t|
    t.integer  "group_id",   limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "group_members", ["group_id"], name: "index_group_members_on_group_id", using: :btree
  add_index "group_members", ["user_id"], name: "index_group_members_on_user_id", using: :btree

  create_table "groups", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "items", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "color",      limit: 255
    t.boolean  "status"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "orders", force: :cascade do |t|
    t.string   "order_number",         limit: 255
    t.string   "sku",                  limit: 255
    t.text     "shipping_address",     limit: 65535
    t.date     "latest_shipping_date"
    t.string   "order_status",         limit: 255
    t.string   "customer_name",        limit: 255
    t.string   "warehouse_status",     limit: 255
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "permissions", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.integer  "group_id",    limit: 4
    t.integer  "resource_id", limit: 4
    t.string   "name",        limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "permissions", ["group_id"], name: "index_permissions_on_group_id", using: :btree
  add_index "permissions", ["resource_id"], name: "index_permissions_on_resource_id", using: :btree
  add_index "permissions", ["user_id"], name: "index_permissions_on_user_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "sku",                 limit: 255
    t.string   "product_name",        limit: 255
    t.text     "image_url1",          limit: 65535
    t.text     "image_url2",          limit: 65535
    t.text     "image_url3",          limit: 65535
    t.text     "product_description", limit: 65535
    t.string   "category",            limit: 255
    t.string   "color",               limit: 255
    t.string   "vendor",              limit: 255
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "resources", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "name",       limit: 255
    t.string   "data",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "resources", ["user_id"], name: "index_resources_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "visiteds", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "produce_id", limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "warehouse_units", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.text     "sku",        limit: 65535
    t.integer  "count",      limit: 4
    t.string   "status",     limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_foreign_key "group_members", "groups"
  add_foreign_key "group_members", "users"
  add_foreign_key "permissions", "groups"
  add_foreign_key "permissions", "resources"
  add_foreign_key "permissions", "users"
  add_foreign_key "resources", "users"
end
