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

ActiveRecord::Schema.define(version: 20160422112424) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "samples", force: :cascade do |t|
    t.datetime "capture_time"
    t.integer  "sensor_id"
    t.integer  "light"
    t.integer  "soil_moisture"
    t.integer  "air_temperature"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "samples", ["capture_time"], name: "index_samples_on_capture_time", using: :btree
  add_index "samples", ["sensor_id"], name: "index_samples_on_sensor_id", using: :btree

end
