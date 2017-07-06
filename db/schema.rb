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

ActiveRecord::Schema.define(version: 20170627164157) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "media", force: :cascade do |t|
    t.string "title"
    t.text "caption"
    t.string "original_image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "modes", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stop_media", force: :cascade do |t|
    t.bigint "stop_id"
    t.bigint "medium_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["medium_id"], name: "index_stop_media_on_medium_id"
    t.index ["stop_id"], name: "index_stop_media_on_stop_id"
  end

  create_table "stops", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "metadescription", limit: 500
    t.string "article_link"
    t.string "video_embed"
    t.string "video_poster"
    t.decimal "lat", precision: 100, scale: 8
    t.decimal "lng", precision: 100, scale: 8
    t.decimal "parking_lat", precision: 100, scale: 8
    t.decimal "parking_lng", precision: 100, scale: 8
    t.text "direction_intro"
    t.text "direction_notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "themes", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tour_modes", force: :cascade do |t|
    t.bigint "tour_id"
    t.bigint "mode_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mode_id"], name: "index_tour_modes_on_mode_id"
    t.index ["tour_id"], name: "index_tour_modes_on_tour_id"
  end

  create_table "tour_sets", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tour_stops", force: :cascade do |t|
    t.bigint "tour_id"
    t.bigint "stop_id"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stop_id"], name: "index_tour_stops_on_stop_id"
    t.index ["tour_id"], name: "index_tour_stops_on_tour_id"
  end

  create_table "tours", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "splash_image"
    t.boolean "is_geo"
    t.boolean "published"
    t.bigint "theme_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["theme_id"], name: "index_tours_on_theme_id"
  end

end
