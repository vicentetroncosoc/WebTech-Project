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

ActiveRecord::Schema[8.0].define(version: 2025_10_10_013739) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "badges", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_badges_on_code", unique: true
  end

  create_table "challenge_tags", force: :cascade do |t|
    t.bigint "challenge_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["challenge_id", "tag_id"], name: "index_challenge_tags_on_challenge_id_and_tag_id", unique: true
    t.index ["challenge_id"], name: "index_challenge_tags_on_challenge_id"
    t.index ["tag_id"], name: "index_challenge_tags_on_tag_id"
  end

  create_table "challenges", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.bigint "owner_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "category"
    t.string "frequency", default: "daily", null: false
    t.integer "points_per_entry", default: 1, null: false
    t.integer "max_entries_per_period", default: 1, null: false
    t.boolean "is_approval_required", default: false, null: false
    t.string "status", default: "draft", null: false
    t.index ["name"], name: "index_challenges_on_name", unique: true
    t.index ["owner_id"], name: "index_challenges_on_owner_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title", limit: 120
    t.string "body", limit: 255
    t.datetime "read_at"
    t.string "notifiable_type"
    t.bigint "notifiable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["notifiable_type", "notifiable_id"], name: "index_notifications_on_notifiable_type_and_notifiable_id"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "participations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "challenge_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role", default: "participant", null: false
    t.string "state", default: "active", null: false
    t.integer "total_points", default: 0, null: false
    t.datetime "joined_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "left_at"
    t.index ["challenge_id"], name: "index_participations_on_challenge_id"
    t.index ["user_id", "challenge_id"], name: "index_participations_on_user_id_and_challenge_id", unique: true
    t.index ["user_id"], name: "index_participations_on_user_id"
  end

  create_table "progress_entries", force: :cascade do |t|
    t.bigint "participation_id", null: false
    t.date "logged_on", null: false
    t.decimal "quantity", precision: 10, scale: 2, null: false
    t.string "note", limit: 255
    t.integer "points_awarded", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["participation_id"], name: "index_progress_entries_on_participation_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "user_badges", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "badge_id", null: false
    t.datetime "earned_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["badge_id"], name: "index_user_badges_on_badge_id"
    t.index ["user_id", "badge_id"], name: "index_user_badges_on_user_id_and_badge_id", unique: true
    t.index ["user_id"], name: "index_user_badges_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "avatar_url"
    t.text "bio"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "challenge_tags", "challenges"
  add_foreign_key "challenge_tags", "tags"
  add_foreign_key "challenges", "users", column: "owner_id"
  add_foreign_key "notifications", "users"
  add_foreign_key "participations", "challenges"
  add_foreign_key "participations", "users"
  add_foreign_key "progress_entries", "participations"
  add_foreign_key "user_badges", "badges"
  add_foreign_key "user_badges", "users"
end
