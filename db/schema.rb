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

ActiveRecord::Schema.define(version: 2019_03_31_182510) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "flat_pages", force: :cascade do |t|
    t.string "title"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position"
  end

  create_table "logins", force: :cascade do |t|
    t.string "identification", null: false
    t.string "password_digest"
    t.string "oauth2_token", null: false
    t.string "uid"
    t.string "single_use_oauth2_token"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "confirm_token"
    t.index ["user_id"], name: "index_logins_on_user_id"
  end

  create_table "media", force: :cascade do |t|
    t.string "title"
    t.text "caption"
    t.string "original_image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "video"
    t.string "provider"
    t.string "embed"
    t.integer "desktop_width"
    t.integer "desktop_height"
    t.integer "tablet_width"
    t.integer "tablet_height"
    t.integer "mobile_width"
    t.integer "mobile_height"
  end

  create_table "modes", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "icon"
  end

  create_table "roles", force: :cascade do |t|
    t.string "title"
  end

  create_table "slugs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "slug"
    t.bigint "tour_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tour_id"], name: "index_slugs_on_tour_id"
  end

  create_table "stop_media", force: :cascade do |t|
    t.bigint "stop_id"
    t.bigint "medium_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position"
    t.index ["medium_id"], name: "index_stop_media_on_medium_id"
    t.index ["stop_id"], name: "index_stop_media_on_stop_id"
  end

  create_table "stop_slugs", force: :cascade do |t|
    t.string "slug"
    t.bigint "stop_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stop_id"], name: "index_stop_slugs_on_stop_id"
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
    t.string "address"
    t.bigint "medium_id"
    t.index ["medium_id"], name: "index_stops_on_medium_id"
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

  create_table "tour_authors", force: :cascade do |t|
    t.bigint "tour_id"
    t.bigint "user_id"
    t.index ["tour_id"], name: "index_tour_authors_on_tour_id"
    t.index ["user_id"], name: "index_tour_authors_on_user_id"
  end

  create_table "tour_collections", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tour_flat_pages", force: :cascade do |t|
    t.bigint "tour_id"
    t.bigint "flat_page_id"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flat_page_id"], name: "index_tour_flat_pages_on_flat_page_id"
    t.index ["tour_id"], name: "index_tour_flat_pages_on_tour_id"
  end

  create_table "tour_media", force: :cascade do |t|
    t.bigint "tour_id"
    t.bigint "medium_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position"
    t.index ["medium_id"], name: "index_tour_media_on_medium_id"
    t.index ["tour_id"], name: "index_tour_media_on_tour_id"
  end

  create_table "tour_modes", force: :cascade do |t|
    t.bigint "tour_id"
    t.bigint "mode_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mode_id"], name: "index_tour_modes_on_mode_id"
    t.index ["tour_id"], name: "index_tour_modes_on_tour_id"
  end

  create_table "tour_set_admins", force: :cascade do |t|
    t.bigint "tour_set_id"
    t.bigint "user_id"
    t.bigint "role_id"
    t.bigint "tour_id"
    t.index ["role_id"], name: "index_tour_set_admins_on_role_id"
    t.index ["tour_set_id"], name: "index_tour_set_admins_on_tour_set_id"
    t.index ["user_id"], name: "index_tour_set_admins_on_user_id"
  end

  create_table "tour_sets", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "subdir"
    t.bigint "tour_id"
    t.string "external_url"
    t.text "notes"
    t.string "logo"
    t.string "footer_logo"
    t.index ["tour_id"], name: "index_tour_sets_on_tours_id"
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
    t.text "article_link"
    t.text "google_analytics"
    t.boolean "is_geo"
    t.boolean "published"
    t.bigint "theme_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "mode_id"
    t.integer "position"
    t.integer "splash_image_medium_id"
    t.string "meta_description"
    t.bigint "medium_id"
    t.string "map_type"
    t.index ["medium_id"], name: "index_tours_on_medium_id"
    t.index ["mode_id"], name: "index_tours_on_mode_id"
    t.index ["theme_id"], name: "index_tours_on_theme_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "display_name"
    t.bigint "login_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "super", default: false
    t.index ["login_id"], name: "index_users_on_login_id", unique: true
  end

  add_foreign_key "stops", "media"
  add_foreign_key "tour_set_admins", "roles"
  add_foreign_key "tour_sets", "tours"
  add_foreign_key "tours", "media"
  add_foreign_key "tours", "media", column: "splash_image_medium_id"
  add_foreign_key "tours", "modes"
  add_foreign_key "users", "logins"
end
