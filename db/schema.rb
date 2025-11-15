# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2025_11_15_014201) do
  create_table "events", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "gift_suggestions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "recipient_id", null: false
    t.integer "event_id", null: false
    t.string "title"
    t.text "description"
    t.integer "estimated_price"
    t.string "source"
    t.string "context_key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_gift_suggestions_on_event_id"
    t.index ["recipient_id"], name: "index_gift_suggestions_on_recipient_id"
    t.index ["user_id"], name: "index_gift_suggestions_on_user_id"
  end

  create_table "reminders", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "event_id", null: false
    t.datetime "send_at"
    t.string "status"
    t.string "channel"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_reminders_on_event_id"
    t.index ["user_id"], name: "index_reminders_on_user_id"
  end

  add_foreign_key "gift_suggestions", "events"
  add_foreign_key "gift_suggestions", "recipients"
  add_foreign_key "gift_suggestions", "users"
  add_foreign_key "reminders", "events"
  add_foreign_key "reminders", "users"
end
