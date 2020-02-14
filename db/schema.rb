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

ActiveRecord::Schema.define(version: 2020_02_14_071057) do

  create_table "boxes", force: :cascade do |t|
    t.integer "pos_x"
    t.integer "pos_y"
    t.integer "plot_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plot_id"], name: "index_boxes_on_plot_id"
  end

  create_table "crops", force: :cascade do |t|
    t.date "date"
    t.boolean "active", default: false
    t.integer "plot_id"
    t.integer "item_id"
    t.string "state"
    t.boolean "present_in_plot", default: true
    t.integer "box_id"
    t.integer "spacing_id"
    t.index ["item_id"], name: "index_crops_on_item_id"
    t.index ["plot_id"], name: "index_crops_on_plot_id"
  end

  create_table "fidjis", force: :cascade do |t|
    t.string "name"
    t.string "family"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "height"
    t.decimal "min_box"
    t.decimal "max_units"
    t.decimal "min_units"
    t.integer "cost_units"
    t.string "friends"
    t.string "enemies"
  end

  create_table "form_properties", force: :cascade do |t|
    t.string "name"
    t.string "options"
    t.boolean "multiple"
    t.string "html"
    t.text "description"
  end

  create_table "gardens", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items_groups", force: :cascade do |t|
    t.integer "item_id"
    t.integer "group_id"
    t.index ["group_id"], name: "index_items_groups_on_group_id"
    t.index ["item_id"], name: "index_items_groups_on_item_id"
  end

  create_table "nurseries", force: :cascade do |t|
    t.integer "garden_id"
    t.index ["garden_id"], name: "index_nurseries_on_garden_id"
  end

  create_table "nursery_items", force: :cascade do |t|
    t.integer "item_id"
    t.string "cultivar"
    t.integer "quantity", default: 1
    t.date "birthdate"
    t.integer "happiness"
    t.string "state"
    t.string "type"
    t.integer "nursery_id"
    t.index ["item_id"], name: "index_nursery_items_on_item_id"
  end

  create_table "plots", force: :cascade do |t|
    t.string "name"
    t.integer "length_cm"
    t.integer "width_cm"
    t.integer "garden_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "geometry"
    t.index ["garden_id"], name: "index_plots_on_garden_id"
  end

  create_table "properties", force: :cascade do |t|
    t.integer "item_id"
    t.string "value"
    t.integer "form_property_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["form_property_id"], name: "index_properties_on_form_property_id"
    t.index ["item_id"], name: "index_properties_on_item_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "item_id"
    t.boolean "is_friend"
    t.integer "other_item_id"
    t.integer "group_id"
    t.integer "other_group_id"
    t.index ["item_id"], name: "index_relationships_on_item_id"
  end

  create_table "spacings", force: :cascade do |t|
    t.string "options"
    t.integer "item_id"
    t.index ["item_id"], name: "index_spacings_on_item_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
