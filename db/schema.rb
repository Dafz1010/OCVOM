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

ActiveRecord::Schema[7.0].define(version: 2022_11_04_133334) do
  create_table "adoptions", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.integer "dog_id", null: false
    t.date "date_adopted"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_adoptions_on_customer_id"
    t.index ["dog_id"], name: "index_adoptions_on_dog_id"
  end

  create_table "appointments", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.integer "dog_id", null: false
    t.date "booked_appointment_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_appointments_on_customer_id"
    t.index ["dog_id"], name: "index_appointments_on_dog_id"
  end

  create_table "breeds", force: :cascade do |t|
    t.string "name"
    t.string "group"
    t.string "origin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dog_states", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dogs", force: :cascade do |t|
    t.integer "breed_id", null: false
    t.string "location"
    t.boolean "has_color"
    t.integer "dog_state_id", null: false
    t.string "image_file_name"
    t.integer "age"
    t.boolean "gender"
    t.boolean "in_pound"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["breed_id"], name: "index_dogs_on_breed_id"
    t.index ["dog_state_id"], name: "index_dogs_on_dog_state_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "password_digest"
    t.integer "role_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "adoptions", "customers"
  add_foreign_key "adoptions", "dogs"
  add_foreign_key "appointments", "customers"
  add_foreign_key "appointments", "dogs"
  add_foreign_key "dogs", "breeds"
  add_foreign_key "dogs", "dog_states"
  add_foreign_key "users", "roles"
end
