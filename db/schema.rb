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

ActiveRecord::Schema[7.1].define(version: 2024_07_10_003019) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "goodgymers", force: :cascade do |t|
    t.integer "role"
    t.string "area_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pairings", force: :cascade do |t|
    t.integer "session_id"
    t.integer "goodgymer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["goodgymer_id", "session_id"], name: "index_pairings_on_goodgymer_id_and_session_id", unique: true
  end

  create_table "registrations", force: :cascade do |t|
    t.integer "goodgymer_id"
    t.integer "session_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["goodgymer_id", "session_id"], name: "index_registrations_on_goodgymer_id_and_session_id", unique: true
  end

  create_table "sessions", force: :cascade do |t|
    t.string "name"
    t.string "area_id"
    t.string "session_id"
    t.integer "created_by"
    t.integer "session_type"
    t.bigint "registration_limit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date"
    t.string "address"
    t.time "start_time"
    t.text "description"
    t.index ["created_by"], name: "index_sessions_on_created_by"
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["session_type"], name: "index_sessions_on_session_type"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name"
    t.string "email"
    t.boolean "profile_completed", default: false
    t.json "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

end
