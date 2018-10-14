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

ActiveRecord::Schema.define(version: 2018_10_14_145628) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_trgm"
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "auth_tokens", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_auth_tokens_on_user_id"
  end

  create_table "compilers", force: :cascade do |t|
    t.string "name", null: false
    t.string "version", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "memory_a", null: false
    t.float "memory_b", null: false
    t.float "time_a", null: false
    t.float "time_b", null: false
    t.integer "status", default: 0
    t.index ["name"], name: "index_compilers_on_name"
  end

  create_table "examples", force: :cascade do |t|
    t.string "input"
    t.string "answer"
    t.bigint "problem_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["problem_id"], name: "index_examples_on_problem_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name", null: false
    t.integer "visibility", default: 0, null: false
    t.bigint "owner_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.index ["name"], name: "index_groups_on_name"
    t.index ["owner_id"], name: "index_groups_on_owner_id"
  end

  create_table "groups_users", id: false, force: :cascade do |t|
    t.bigint "group_id", null: false
    t.bigint "user_id", null: false
    t.index ["group_id"], name: "index_groups_users_on_group_id"
    t.index ["user_id"], name: "index_groups_users_on_user_id"
  end

  create_table "invites", force: :cascade do |t|
    t.bigint "sender_id", null: false
    t.bigint "receiver_id", null: false
    t.bigint "group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0, null: false
    t.index ["group_id"], name: "index_invites_on_group_id"
    t.index ["receiver_id"], name: "index_invites_on_receiver_id"
    t.index ["sender_id"], name: "index_invites_on_sender_id"
  end

  create_table "logs", force: :cascade do |t|
    t.text "data", null: false
    t.integer "type", null: false
    t.bigint "submission_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["submission_id"], name: "index_logs_on_submission_id"
  end

  create_table "problem_translations", force: :cascade do |t|
    t.integer "language"
    t.string "caption"
    t.string "author"
    t.text "text"
    t.text "technical_text"
    t.bigint "problem_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "default", default: false, null: false
    t.index ["problem_id"], name: "index_problem_translations_on_problem_id"
  end

  create_table "problems", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "checker_compiler_id", null: false
    t.float "memory_limit", null: false
    t.float "time_limit", null: false
    t.float "real_time_limit", null: false
    t.bigint "user_id"
    t.index ["checker_compiler_id"], name: "index_problems_on_checker_compiler_id"
    t.index ["user_id"], name: "index_problems_on_user_id"
  end

  create_table "problems_tags", force: :cascade do |t|
    t.bigint "problem_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["problem_id"], name: "index_problems_tags_on_problem_id"
    t.index ["tag_id"], name: "index_problems_tags_on_tag_id"
  end

  create_table "results", force: :cascade do |t|
    t.integer "status", null: false
    t.bigint "submission_id", null: false
    t.bigint "test_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "log"
    t.float "memory", null: false
    t.float "time", null: false
    t.index ["submission_id"], name: "index_results_on_submission_id"
    t.index ["test_id"], name: "index_results_on_test_id"
  end

  create_table "submissions", force: :cascade do |t|
    t.bigint "problem_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.integer "test_state", default: 0, null: false
    t.integer "fails_count", default: 0, null: false
    t.bigint "compiler_id", null: false
    t.float "score"
    t.integer "test_result"
    t.index ["compiler_id"], name: "index_submissions_on_compiler_id"
    t.index ["problem_id"], name: "index_submissions_on_problem_id"
    t.index ["test_state"], name: "index_submissions_on_test_state"
    t.index ["user_id"], name: "index_submissions_on_user_id"
  end

  create_table "tag_translations", force: :cascade do |t|
    t.integer "language"
    t.string "name"
    t.bigint "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tag_id"], name: "index_tag_translations_on_tag_id"
  end

  create_table "tags", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tests", force: :cascade do |t|
    t.string "num"
    t.bigint "problem_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["problem_id"], name: "index_tests_on_problem_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.bigint "score", default: 0
    t.boolean "administrator", default: false, null: false
    t.string "skills"
    t.string "city"
    t.string "institution"
    t.string "username", null: false
    t.index ["city"], name: "index_users_on_city", opclass: :gist_trgm_ops, using: :gist
    t.index ["email"], name: "index_users_on_email"
    t.index ["institution"], name: "index_users_on_institution", opclass: :gist_trgm_ops, using: :gist
    t.index ["username"], name: "index_users_on_username", opclass: :gist_trgm_ops, using: :gist
  end

  add_foreign_key "auth_tokens", "users"
  add_foreign_key "examples", "problems"
  add_foreign_key "groups", "users", column: "owner_id"
  add_foreign_key "groups_users", "groups"
  add_foreign_key "groups_users", "users"
  add_foreign_key "invites", "groups"
  add_foreign_key "invites", "users", column: "receiver_id"
  add_foreign_key "invites", "users", column: "sender_id"
  add_foreign_key "problem_translations", "problems"
  add_foreign_key "problems", "compilers", column: "checker_compiler_id"
  add_foreign_key "problems", "users"
  add_foreign_key "problems_tags", "problems"
  add_foreign_key "problems_tags", "tags"
  add_foreign_key "submissions", "compilers"
  add_foreign_key "submissions", "problems"
  add_foreign_key "submissions", "users"
  add_foreign_key "tag_translations", "tags"
  add_foreign_key "tests", "problems"
end
