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

ActiveRecord::Schema.define(version: 20170711174350) do

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

  create_table "stop_tags", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "taggings", id: :serial, force: :cascade do |t|
    t.integer "tag_id"
    t.string "taggable_type"
    t.integer "taggable_id"
    t.string "tagger_type"
    t.integer "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
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

  create_table "tour_tags", force: :cascade do |t|
    t.string "title"
    t.decimal "lat", precision: 100, scale: 8
    t.decimal "lng", precision: 100, scale: 8
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
