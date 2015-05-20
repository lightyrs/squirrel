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

ActiveRecord::Schema.define(version: 20150519231016) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "classifications", force: :cascade do |t|
    t.string   "name",            null: false
    t.text     "description"
    t.integer  "content_type_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "classifications", ["content_type_id"], name: "index_classifications_on_content_type_id", using: :btree
  add_index "classifications", ["name", "content_type_id"], name: "index_classifications_on_name_and_content_type_id", unique: true, using: :btree

  create_table "content_types", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "content_types", ["name"], name: "index_content_types_on_name", unique: true, using: :btree

  create_table "documents", force: :cascade do |t|
    t.string   "url",                 null: false
    t.string   "title"
    t.text     "description"
    t.string   "best_image_url"
    t.string   "author"
    t.string   "keywords",                         array: true
    t.string   "content_type_header"
    t.string   "charset"
    t.string   "og_type"
    t.integer  "classification_id",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "documents", ["classification_id"], name: "index_documents_on_classification_id", using: :btree
  add_index "documents", ["keywords"], name: "index_documents_on_keywords", using: :gin
  add_index "documents", ["url", "classification_id"], name: "index_documents_on_url_and_classification_id", unique: true, using: :btree

end
