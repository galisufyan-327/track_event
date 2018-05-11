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

ActiveRecord::Schema.define(version: 20180412113107) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "company_users", force: :cascade do |t|
    t.integer  "orignal_id",              null: false
    t.integer  "company_id"
    t.string   "guid",                    null: false
    t.string   "email",      default: "", null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "level",      default: 0
    t.index ["guid"], name: "index_company_users_on_guid", unique: true, using: :btree
  end

  create_table "events", force: :cascade do |t|
    t.integer  "company_id"
    t.string   "target_type"
    t.string   "target_uuid"
    t.integer  "event_type"
    t.datetime "trigered_at"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "company_user_id"
    t.integer  "deleted_by"
    t.datetime "deleted_at"
    t.index ["company_user_id"], name: "index_events_on_company_user_id", using: :btree
  end

  create_table "reward_points", force: :cascade do |t|
    t.string   "reward_type",                 null: false
    t.integer  "points",          default: 0
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "company_id"
    t.integer  "company_user_id"
    t.integer  "level"
    t.index ["company_user_id"], name: "index_reward_points_on_company_user_id", using: :btree
  end

end
