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

ActiveRecord::Schema.define(version: 20140609200658) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: true do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "bio"
  end

  create_table "cart_items", force: true do |t|
    t.integer  "product_id"
    t.integer  "cart_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "carts", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.string   "name"
    t.float    "hardcover_price"
    t.float    "softcover_price"
    t.string   "image_url"
    t.string   "description"
    t.date     "published_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "author_id"
    t.integer  "publisher_id"
  end

  add_index "products", ["author_id"], name: "index_products_on_author_id", using: :btree
  add_index "products", ["publisher_id"], name: "index_products_on_publisher_id", using: :btree

  create_table "publishers", force: true do |t|
    t.string   "city"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string  "email"
    t.string  "password_digest"
    t.boolean "admin"
    t.string  "reset_token"
  end

end
