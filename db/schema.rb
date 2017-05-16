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

ActiveRecord::Schema.define(version: 20170422101624) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.string   "content"
    t.integer  "quote_comment"
    t.integer  "status"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "image_id",      default: 0, null: false
    t.integer  "user_id",       default: 0, null: false
    t.index ["image_id", "user_id"], name: "index_comments_on_image_id_and_user_id", using: :btree
  end

  create_table "images", force: :cascade do |t|
    t.string   "url"
    t.string   "title"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "user_id"
    t.string   "img_file_file_name"
    t.string   "img_file_content_type"
    t.integer  "img_file_file_size"
    t.datetime "img_file_updated_at"
    t.index ["user_id"], name: "index_images_on_user_id", using: :btree
  end

  create_table "likes", force: :cascade do |t|
    t.integer  "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.integer  "image_id"
    t.index ["image_id", "user_id"], name: "index_likes_on_image_id_and_user_id", unique: true, using: :btree
    t.index ["image_id"], name: "index_likes_on_image_id", using: :btree
    t.index ["user_id"], name: "index_likes_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "password",   default: "",      null: false
    t.integer  "invited_by", default: 0,       null: false
    t.string   "locale",     default: "zh-CN", null: false
  end

end
