# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.


ActiveRecord::Schema.define(version: 2020_11_02_122509) do


  # These are extensions that must be enabled in order to support this database
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

  create_table "chatrooms", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "cities", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "country"
    t.float "latitude"
    t.float "longitude"
    t.string "quality_of_life"
    t.integer "income"
    t.integer "living_cost"
    t.string "traffic"
    t.integer "population"
    t.string "currency"
    t.string "weather"
    t.integer "score"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "city_details", force: :cascade do |t|
    t.string "title"
    t.float "value"
    t.bigint "city_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["city_id"], name: "index_city_details_on_city_id"
  end

  create_table "cost_of_livings", force: :cascade do |t|
    t.string "title"
    t.float "price"
    t.bigint "city_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["city_id"], name: "index_cost_of_livings_on_city_id"
  end

  create_table "interests", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "messages", force: :cascade do |t|
    t.string "content"
    t.bigint "chatroom_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["chatroom_id"], name: "index_messages_on_chatroom_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "occupations", force: :cascade do |t|
    t.string "title"
    t.integer "salary"
    t.bigint "city_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["city_id"], name: "index_occupations_on_city_id"
  end

  create_table "responses", force: :cascade do |t|
    t.text "content"
    t.bigint "survey_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["survey_id"], name: "index_responses_on_survey_id"
    t.index ["user_id"], name: "index_responses_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.text "content"
    t.integer "stars"
    t.string "reviewable_type", null: false
    t.bigint "reviewable_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["reviewable_type", "reviewable_id"], name: "index_reviews_on_reviewable_type_and_reviewable_id"
  end

  create_table "surveys", force: :cascade do |t|
    t.text "question"
    t.bigint "city_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["city_id"], name: "index_surveys_on_city_id"
    t.index ["user_id"], name: "index_surveys_on_user_id"
  end

  create_table "user_cities", force: :cascade do |t|
    t.string "title"
    t.bigint "user_id", null: false
    t.bigint "city_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["city_id"], name: "index_user_cities_on_city_id"
    t.index ["user_id"], name: "index_user_cities_on_user_id"
  end

  create_table "user_interests", force: :cascade do |t|
    t.string "title"
    t.bigint "interest_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["interest_id"], name: "index_user_interests_on_interest_id"
    t.index ["user_id"], name: "index_user_interests_on_user_id"
  end

  create_table "user_occupations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "occupation_id", null: false
    t.bigint "city_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["city_id"], name: "index_user_occupations_on_city_id"
    t.index ["occupation_id"], name: "index_user_occupations_on_occupation_id"
    t.index ["user_id"], name: "index_user_occupations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.string "username"
    t.string "password"
    t.text "description"
    t.string "image_url"
    t.integer "score"
    t.string "current_city"
    t.bigint "occupation_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["occupation_id"], name: "index_users_on_occupation_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "city_details", "cities"
  add_foreign_key "cost_of_livings", "cities"
  add_foreign_key "messages", "chatrooms"
  add_foreign_key "messages", "users"
  add_foreign_key "occupations", "cities"
  add_foreign_key "responses", "surveys"
  add_foreign_key "responses", "users"
  add_foreign_key "surveys", "cities"
  add_foreign_key "surveys", "users"
  add_foreign_key "user_cities", "cities"
  add_foreign_key "user_cities", "users"
  add_foreign_key "user_interests", "interests"
  add_foreign_key "user_interests", "users"
  add_foreign_key "user_occupations", "cities"
  add_foreign_key "user_occupations", "occupations"
  add_foreign_key "user_occupations", "users"
  add_foreign_key "users", "occupations"
end
