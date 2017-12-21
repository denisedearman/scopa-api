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

ActiveRecord::Schema.define(version: 20171221013206) do

  create_table "cards", force: :cascade do |t|
    t.string "suit"
    t.integer "value"
    t.integer "points"
    t.boolean "in_deck"
    t.boolean "captured"
    t.integer "player_game_id"
    t.integer "game_id"
  end

  create_table "games", force: :cascade do |t|
    t.boolean "complete"
    t.boolean "points_awarded", default: false
  end

  create_table "player_games", force: :cascade do |t|
    t.integer "player_id"
    t.integer "game_id"
    t.integer "points", default: 0
    t.integer "scopa_count", default: 0
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "like", default: 0
  end

end
