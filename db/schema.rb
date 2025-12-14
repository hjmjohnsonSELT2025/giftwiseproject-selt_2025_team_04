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

ActiveRecord::Schema[7.1].define(version: 2025_12_13_234401) do
  create_table "dislikes", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "item"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_dislikes_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "title"
    t.string "location"
    t.string "theme"
    t.text "description"
    t.datetime "date"
    t.time "start_time"
    t.integer "owner_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_events_on_owner_id"
  end

  create_table "events_recipients", id: false, force: :cascade do |t|
    t.integer "event_id"
    t.integer "recipient_id"
    t.index ["event_id"], name: "index_events_recipients_on_event_id"
    t.index ["recipient_id"], name: "index_events_recipients_on_recipient_id"
  end

  create_table "events_users", id: false, force: :cascade do |t|
    t.integer "event_id"
    t.integer "user_id"
    t.index ["event_id"], name: "index_events_users_on_event_id"
    t.index ["user_id"], name: "index_events_users_on_user_id"
  end

  create_table "friend_requests", force: :cascade do |t|
    t.integer "requestee_id", null: false
    t.integer "requester_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["requestee_id"], name: "index_friend_requests_on_requestee_id"
    t.index ["requester_id"], name: "index_friend_requests_on_requester_id"
  end

  create_table "friends", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "friend_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["friend_id"], name: "index_friends_on_friend_id"
    t.index ["user_id", "friend_id"], name: "index_friends_on_user_id_and_friend_id", unique: true
    t.index ["user_id"], name: "index_friends_on_user_id"
  end

  create_table "gift_comments", force: :cascade do |t|
    t.integer "user_id", null: false
    t.text "content"
    t.integer "gift_id", null: false
    t.integer "parent_id"
    t.integer "thread"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["gift_id"], name: "index_gift_comments_on_gift_id"
    t.index ["parent_id"], name: "index_gift_comments_on_parent_id"
    t.index ["user_id"], name: "index_gift_comments_on_user_id"
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
    t.string "best_vendor_name"
    t.string "best_vendor_url"
    t.decimal "best_vendor_price"
    t.index ["event_id"], name: "index_gift_suggestions_on_event_id"
    t.index ["recipient_id"], name: "index_gift_suggestions_on_recipient_id"
    t.index ["user_id"], name: "index_gift_suggestions_on_user_id"
  end

  create_table "gifts", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "user_id", null: false
    t.integer "recipient_id"
    t.float "price"
    t.integer "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "visibility", default: 0
    t.string "best_vendor_name"
    t.string "best_vendor_url"
    t.decimal "best_vendor_price"
    t.integer "gift_suggestion_id"
    t.index ["event_id"], name: "index_gifts_on_event_id"
    t.index ["recipient_id"], name: "index_gifts_on_recipient_id"
    t.index ["user_id"], name: "index_gifts_on_user_id"
  end

  create_table "likes", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "item"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "recipients", force: :cascade do |t|
    t.string "name"
    t.integer "age"
    t.string "occupation"
    t.text "hobbies"
    t.text "likes"
    t.text "dislikes"
    t.decimal "budget"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "assigned_user_id"
    t.index ["assigned_user_id"], name: "index_recipients_on_assigned_user_id"
    t.index ["user_id"], name: "index_recipients_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.string "preferred_name"
    t.integer "age"
    t.string "job"
    t.string "pronouns"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "dislikes", "users"
  add_foreign_key "events", "users", column: "owner_id"
  add_foreign_key "friend_requests", "users", column: "requestee_id"
  add_foreign_key "friend_requests", "users", column: "requester_id"
  add_foreign_key "friends", "users"
  add_foreign_key "friends", "users", column: "friend_id"
  add_foreign_key "gift_comments", "gift_comments", column: "parent_id"
  add_foreign_key "gift_comments", "gifts"
  add_foreign_key "gift_comments", "users"
  add_foreign_key "gift_suggestions", "events"
  add_foreign_key "gift_suggestions", "recipients"
  add_foreign_key "gift_suggestions", "users"
  add_foreign_key "gifts", "events"
  add_foreign_key "gifts", "users"
  add_foreign_key "likes", "users"
  add_foreign_key "recipients", "users"
  add_foreign_key "recipients", "users", column: "assigned_user_id"
end
