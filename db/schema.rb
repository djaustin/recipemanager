# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150628174326) do

  create_table "chefs", force: true do |t|
    t.string   "chefname"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.boolean  "admin",           default: false
  end

  create_table "ingredients", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "likes", force: true do |t|
    t.boolean  "like"
    t.integer  "chef_id"
    t.integer  "recipe_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "likes", ["chef_id"], name: "index_likes_on_chef_id"
  add_index "likes", ["recipe_id"], name: "index_likes_on_recipe_id"

  create_table "recipe_ingredients", force: true do |t|
    t.integer  "recipe_id"
    t.integer  "ingredient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "recipe_ingredients", ["ingredient_id"], name: "index_recipe_ingredients_on_ingredient_id"
  add_index "recipe_ingredients", ["recipe_id"], name: "index_recipe_ingredients_on_recipe_id"

  create_table "recipe_styles", force: true do |t|
    t.integer  "recipe_id"
    t.integer  "style_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "recipe_styles", ["recipe_id"], name: "index_recipe_styles_on_recipe_id"
  add_index "recipe_styles", ["style_id"], name: "index_recipe_styles_on_style_id"

  create_table "recipes", force: true do |t|
    t.string   "name"
    t.text     "summary"
    t.text     "description"
    t.integer  "chef_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
  end

  add_index "recipes", ["chef_id"], name: "index_recipes_on_chef_id"

  create_table "styles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
