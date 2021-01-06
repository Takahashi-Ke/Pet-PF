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

ActiveRecord::Schema.define(version: 2021_01_06_010054) do

  create_table "characters", force: :cascade do |t|
    t.integer "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chats", force: :cascade do |t|
    t.integer "pet_id"
    t.integer "room_id"
    t.string "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pet_id"], name: "index_chats_on_pet_id"
    t.index ["room_id"], name: "index_chats_on_room_id"
  end

  create_table "diaries", force: :cascade do |t|
    t.integer "pet_id"
    t.text "body"
    t.string "image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pet_id"], name: "index_diaries_on_pet_id"
  end

  create_table "diary_comments", force: :cascade do |t|
    t.integer "pet_id"
    t.integer "diary_id"
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["diary_id"], name: "index_diary_comments_on_diary_id"
    t.index ["pet_id"], name: "index_diary_comments_on_pet_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.integer "pet_id"
    t.integer "diary_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "memory_id"
    t.index ["diary_id"], name: "index_favorites_on_diary_id"
    t.index ["pet_id"], name: "index_favorites_on_pet_id"
  end

  create_table "memories", force: :cascade do |t|
    t.integer "pet_id"
    t.string "title"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pet_id"], name: "index_memories_on_pet_id"
  end

  create_table "memory_comments", force: :cascade do |t|
    t.integer "pet_id"
    t.integer "memory_id"
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["memory_id"], name: "index_memory_comments_on_memory_id"
    t.index ["pet_id"], name: "index_memory_comments_on_pet_id"
  end

  create_table "memory_images", force: :cascade do |t|
    t.integer "memory_id"
    t.string "image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["memory_id"], name: "index_memory_images_on_memory_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "diary_id"
    t.integer "visitor_id"
    t.integer "visited_id"
    t.integer "diary_comment_id"
    t.string "action"
    t.boolean "is_checked", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "memory_id"
    t.string "memory_comment_id"
    t.index ["diary_comment_id"], name: "index_notifications_on_diary_comment_id"
    t.index ["diary_id"], name: "index_notifications_on_diary_id"
    t.index ["visited_id"], name: "index_notifications_on_visited_id"
    t.index ["visitor_id"], name: "index_notifications_on_visitor_id"
  end

  create_table "owners", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name"
    t.string "image_id"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_owners_on_email", unique: true
    t.index ["reset_password_token"], name: "index_owners_on_reset_password_token", unique: true
  end

  create_table "pet_characters", force: :cascade do |t|
    t.integer "pet_id"
    t.integer "character_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_pet_characters_on_character_id"
    t.index ["pet_id"], name: "index_pet_characters_on_pet_id"
  end

  create_table "pet_rooms", force: :cascade do |t|
    t.integer "pet_id"
    t.integer "room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pet_id"], name: "index_pet_rooms_on_pet_id"
    t.index ["room_id"], name: "index_pet_rooms_on_room_id"
  end

  create_table "pets", force: :cascade do |t|
    t.integer "owner_id"
    t.string "name", null: false
    t.string "image_id"
    t.date "birthday", null: false
    t.integer "gender", null: false
    t.text "introduction"
    t.integer "type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_pets_on_owner_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
