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

ActiveRecord::Schema.define(version: 20170402004947) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.integer  "project_id"
    t.string   "author"
    t.string   "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_comments_on_project_id", using: :btree
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "total"
    t.datetime "time"
    t.string   "image_url"
    t.string   "slug"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
  end

  create_table "user_funded_projects", force: :cascade do |t|
    t.integer  "amount"
    t.string   "credit_card_number"
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["project_id"], name: "index_user_funded_projects_on_project_id", using: :btree
    t.index ["user_id"], name: "index_user_funded_projects_on_user_id", using: :btree
  end

  create_table "user_roles", force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["role_id"], name: "index_user_roles_on_role_id", using: :btree
    t.index ["user_id"], name: "index_user_roles_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "username"
    t.string   "last_name"
    t.string   "password_digest"
    t.string   "email"
    t.string   "phone"
    t.string   "avatar_url"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "slug"
    t.string   "token"
  end

  add_foreign_key "comments", "projects"
  add_foreign_key "user_funded_projects", "projects"
  add_foreign_key "user_funded_projects", "users"
  add_foreign_key "user_roles", "roles"
  add_foreign_key "user_roles", "users"
end
