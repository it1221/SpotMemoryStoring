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

ActiveRecord::Schema.define(version: 2021_06_30_152151) do

  create_table "memories", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "private", default: true
    t.integer "user_id"
    t.integer "spot_id"
    t.index ["created_at", "user_id", "spot_id"], name: "index_memories_on_created_at_and_user_id_and_spot_id"
    t.index ["private"], name: "index_memories_on_private"
    t.index ["spot_id"], name: "index_memories_on_spot_id"
    t.index ["user_id"], name: "index_memories_on_user_id"
  end

  create_table "spots", force: :cascade do |t|
    t.string "address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.boolean "private", default: true
    t.string "name"
    t.index ["address", "user_id"], name: "index_spots_on_address_and_user_id"
    t.index ["private"], name: "index_spots_on_private"
    t.index ["user_id"], name: "index_spots_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.text "introduction"
    t.boolean "admin"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "image_name", default: "default_image"
    t.string "password_digest"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "memories", "spots"
  add_foreign_key "memories", "users"
  add_foreign_key "spots", "users"
end
