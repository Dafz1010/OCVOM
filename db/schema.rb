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

ActiveRecord::Schema[7.0].define(version: 2023_06_18_095254) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

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
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

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

  create_table "age_lists", force: :cascade do |t|
    t.string "name"
    t.string "group"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "assigned_users_vet_records", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.uuid "vet_record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_assigned_users_vet_records_on_user_id"
    t.index ["vet_record_id"], name: "index_assigned_users_vet_records_on_vet_record_id"
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
    t.bigint "user_id", null: false
    t.index ["breed_id"], name: "index_dogs_on_breed_id"
    t.index ["place_id"], name: "index_dogs_on_place_id"
    t.index ["user_id"], name: "index_dogs_on_user_id"
  end

  create_table "dogs_vaccines", id: false, force: :cascade do |t|
    t.bigint "dog_id", null: false
    t.bigint "vaccine_id", null: false
    t.index ["dog_id", "vaccine_id"], name: "index_dogs_vaccines_on_dog_id_and_vaccine_id"
    t.index ["vaccine_id", "dog_id"], name: "index_dogs_vaccines_on_vaccine_id_and_dog_id"
  end

  create_table "inventories", force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.string "manufacturer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "inventory_type"
    t.datetime "archived_at"
  end

  create_table "inventory_items", force: :cascade do |t|
    t.integer "quantity"
    t.decimal "price"
    t.date "expiration_date"
    t.bigint "inventory_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "age_list_id"
    t.datetime "archived_at"
    t.index ["age_list_id"], name: "index_inventory_items_on_age_list_id"
    t.index ["inventory_id"], name: "index_inventory_items_on_inventory_id"
  end

  create_table "medical_histories", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "vet_place"
    t.datetime "date_recorded"
    t.uuid "vet_record_id", null: false
    t.bigint "inventory_item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["inventory_item_id"], name: "index_medical_histories_on_inventory_item_id"
    t.index ["vet_record_id"], name: "index_medical_histories_on_vet_record_id"
  end

  create_table "pet_status_conditions", force: :cascade do |t|
    t.string "name"
    t.boolean "status_or_condition"
    t.string "three_colors"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.datetime "approved_at"
    t.datetime "first_login_at"
    t.index ["role_id"], name: "index_users_on_role_id"
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "vaccines", force: :cascade do |t|
    t.string "name"
    t.datetime "archived_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "vet_records", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "archived_at"
    t.string "species"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "age_list_id", null: false
    t.bigint "place_id", null: false
    t.string "pet_owner"
    t.string "pet_owner_phone"
    t.string "breed"
    t.boolean "pet_gender"
    t.boolean "pet_neutered"
    t.bigint "created_by_user_id", null: false
    t.bigint "status_id"
    t.bigint "condition_id"
    t.index ["age_list_id"], name: "index_vet_records_on_age_list_id"
    t.index ["condition_id"], name: "index_vet_records_on_condition_id"
    t.index ["created_by_user_id"], name: "index_vet_records_on_created_by_user_id"
    t.index ["place_id"], name: "index_vet_records_on_place_id"
    t.index ["status_id"], name: "index_vet_records_on_status_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "adoptions", "customers"
  add_foreign_key "adoptions", "dogs"
  add_foreign_key "appointments", "customers"
  add_foreign_key "appointments", "dogs"
  add_foreign_key "assigned_users_vet_records", "users"
  add_foreign_key "assigned_users_vet_records", "vet_records"
  add_foreign_key "dog_pictures", "dogs"
  add_foreign_key "dogs", "breeds"
  add_foreign_key "dogs", "places"
  add_foreign_key "dogs", "users"
  add_foreign_key "inventory_items", "age_lists"
  add_foreign_key "inventory_items", "inventories"
  add_foreign_key "medical_histories", "inventory_items"
  add_foreign_key "medical_histories", "vet_records"
  add_foreign_key "users", "roles"
  add_foreign_key "vet_records", "age_lists"
  add_foreign_key "vet_records", "age_lists"
  add_foreign_key "vet_records", "pet_status_conditions", column: "condition_id"
  add_foreign_key "vet_records", "pet_status_conditions", column: "status_id"
  add_foreign_key "vet_records", "places"
  add_foreign_key "vet_records", "users", column: "created_by_user_id"
end
