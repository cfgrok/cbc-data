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

ActiveRecord::Schema.define(version: 20210220185454) do

  create_table "areas", force: :cascade do |t|
    t.string   "name"
    t.boolean  "on_island"
    t.integer  "sector_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "areas", ["sector_id"], name: "index_areas_on_sector_id"

  create_table "checklists", force: :cascade do |t|
    t.integer  "survey_id"
    t.integer  "sector_id"
    t.integer  "area_id"
    t.integer  "max_parties"
    t.integer  "min_parties"
    t.boolean  "feeder_watch"
    t.boolean  "on_island"
    t.string   "location"
    t.time     "start_time"
    t.time     "end_time"
    t.float    "break_hours"
    t.float    "hours_foot"
    t.float    "hours_car"
    t.float    "hours_boat"
    t.float    "hours_owling"
    t.float    "hours_total"
    t.float    "miles_foot"
    t.float    "miles_car"
    t.float    "miles_boat"
    t.float    "miles_owling"
    t.float    "miles_total"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "checklists", ["area_id"], name: "index_checklists_on_area_id"
  add_index "checklists", ["sector_id"], name: "index_checklists_on_sector_id"
  add_index "checklists", ["survey_id"], name: "index_checklists_on_survey_id"

  create_table "checklists_observers", id: false, force: :cascade do |t|
    t.integer "checklist_id", null: false
    t.integer "observer_id",  null: false
  end

  create_table "observations", force: :cascade do |t|
    t.integer  "number"
    t.integer  "taxon_id"
    t.integer  "checklist_id"
    t.boolean  "count_week"
    t.string   "notes"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "survey_id"
    t.integer  "sector_id"
  end

  add_index "observations", ["checklist_id"], name: "index_observations_on_checklist_id"
  add_index "observations", ["sector_id"], name: "index_observations_on_sector_id"
  add_index "observations", ["survey_id"], name: "index_observations_on_survey_id"
  add_index "observations", ["taxon_id"], name: "index_observations_on_taxon_id"

  create_table "observers", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sectors", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.boolean  "on_island"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "surveys", force: :cascade do |t|
    t.date     "date"
    t.integer  "year_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "surveys", ["year_id"], name: "index_surveys_on_year_id"

  create_table "taxons", force: :cascade do |t|
    t.string   "common_name"
    t.string   "cbc_name"
    t.string   "scientific_name"
    t.integer  "taxonomic_order"
    t.boolean  "generic"
    t.boolean  "active"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "taxons", ["taxonomic_order"], name: "index_taxons_on_taxonomic_order", unique: true

  create_table "years", force: :cascade do |t|
    t.integer  "audubon_year"
    t.integer  "vashon_year"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

end
