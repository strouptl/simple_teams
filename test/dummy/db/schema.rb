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

ActiveRecord::Schema[7.1].define(version: 2025_01_28_202910) do
  create_table "noticed_events", force: :cascade do |t|
    t.string "type"
    t.string "record_type"
    t.bigint "record_id"
    t.json "params"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "notifications_count"
    t.index ["record_type", "record_id"], name: "index_noticed_events_on_record"
  end

  create_table "noticed_notifications", force: :cascade do |t|
    t.string "type"
    t.bigint "event_id", null: false
    t.string "recipient_type", null: false
    t.bigint "recipient_id", null: false
    t.datetime "read_at", precision: nil
    t.datetime "seen_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_noticed_notifications_on_event_id"
    t.index ["recipient_type", "recipient_id"], name: "index_noticed_notifications_on_recipient"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "simple_teams_invitations", force: :cascade do |t|
    t.integer "team_id", null: false
    t.integer "inviter_id", null: false
    t.integer "membership_id"
    t.string "email", null: false
    t.integer "role", default: 0, null: false
    t.string "token", null: false
    t.integer "status", default: 0
    t.datetime "sent_at"
    t.datetime "expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["inviter_id"], name: "index_simple_teams_invitations_on_inviter_id"
    t.index ["membership_id"], name: "index_simple_teams_invitations_on_membership_id"
    t.index ["team_id"], name: "index_simple_teams_invitations_on_team_id"
  end

  create_table "simple_teams_memberships", force: :cascade do |t|
    t.integer "team_id", null: false
    t.integer "member_id", null: false
    t.integer "role", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_simple_teams_memberships_on_member_id"
    t.index ["team_id"], name: "index_simple_teams_memberships_on_team_id"
  end

  create_table "simple_teams_teams", force: :cascade do |t|
    t.string "teamable_type", null: false
    t.integer "teamable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["teamable_type", "teamable_id"], name: "index_simple_teams_teams_on_teamable"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "simple_teams_invitations", "simple_teams_memberships", column: "membership_id"
  add_foreign_key "simple_teams_invitations", "simple_teams_teams", column: "team_id"
  add_foreign_key "simple_teams_invitations", "users", column: "inviter_id"
  add_foreign_key "simple_teams_memberships", "simple_teams_teams", column: "team_id"
  add_foreign_key "simple_teams_memberships", "users", column: "member_id"
end
