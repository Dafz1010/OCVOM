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

ActiveRecord::Schema[7.0].define(version: 2023_02_02_105132) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "adoptions", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.bigint "dog_id", null: false
    t.date "date_adopted"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "archived_at"
    t.index ["customer_id"], name: "index_adoptions_on_customer_id"
    t.index ["dog_id"], name: "index_adoptions_on_dog_id"
  end

  create_table "appointments", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.bigint "dog_id", null: false
    t.date "booked_appointment_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.datetime "archived_at"
    t.index ["customer_id"], name: "index_appointments_on_customer_id"
    t.index ["dog_id"], name: "index_appointments_on_dog_id"
    t.index ["user_id"], name: "index_appointments_on_user_id"
  end

  create_table "breeds", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "archived_at"
  end

  create_table "conditions", force: :cascade do |t|
    t.string "name"
    t.datetime "archived_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "conditions_dogs", id: false, force: :cascade do |t|
    t.bigint "dog_id", null: false
    t.bigint "condition_id", null: false
    t.index ["condition_id", "dog_id"], name: "index_conditions_dogs_on_condition_id_and_dog_id"
    t.index ["dog_id", "condition_id"], name: "index_conditions_dogs_on_dog_id_and_condition_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "archived_at"
  end

  create_table "dog_pictures", force: :cascade do |t|
    t.bigint "dog_id", null: false
    t.string "image"
    t.datetime "archived_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dog_id"], name: "index_dog_pictures_on_dog_id"
  end

  create_table "dog_states", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "archived_at"
  end

  create_table "dog_states_dogs", id: false, force: :cascade do |t|
    t.bigint "dog_id", null: false
    t.bigint "dog_state_id", null: false
    t.index ["dog_id", "dog_state_id"], name: "index_dog_states_dogs_on_dog_id_and_dog_state_id"
    t.index ["dog_state_id", "dog_id"], name: "index_dog_states_dogs_on_dog_state_id_and_dog_id"
  end

  create_table "dogs", force: :cascade do |t|
    t.bigint "breed_id", null: false
    t.string "images"
    t.integer "age"
    t.boolean "gender"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "archived_at"
    t.bigint "place_id", null: false
    t.uuid "uuid", default: -> { "uuid_generate_v4()" }
    t.boolean "neutered", default: false
    t.string "public_id"
    t.boolean "size", default: true
    t.index ["breed_id"], name: "index_dogs_on_breed_id"
    t.index ["place_id"], name: "index_dogs_on_place_id"
  end

  create_table "places", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "archived_at"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "archived_at"
  end

  create_table "user_policies", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "archived_at"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "username", null: false
    t.string "password_digest"
    t.bigint "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "archived_at"
    t.string "profile_image"
    t.index ["role_id"], name: "index_users_on_role_id"
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "adoptions", "customers"
  add_foreign_key "adoptions", "dogs"
  add_foreign_key "appointments", "customers"
  add_foreign_key "appointments", "dogs"
  add_foreign_key "dog_pictures", "dogs"
  add_foreign_key "dogs", "breeds"
  add_foreign_key "dogs", "places"
  add_foreign_key "users", "roles"
end
