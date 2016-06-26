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

ActiveRecord::Schema.define(version: 20160626205146) do

  create_table "airlines", force: :cascade do |t|
    t.string   "name"
    t.string   "icao"
    t.string   "iata"
    t.integer  "airport_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "airports", force: :cascade do |t|
    t.string   "name"
    t.string   "city"
    t.string   "country"
    t.string   "iata"
    t.string   "icao"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.string   "tz_db"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bookings", force: :cascade do |t|
    t.integer  "flight_id"
    t.integer  "user_id"
    t.decimal  "price",        precision: 8, scale: 2
    t.integer  "booking_code"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "flights", force: :cascade do |t|
    t.datetime "departure_date"
    t.datetime "arrival_date"
    t.integer  "airport_id"
    t.integer  "airline_id"
    t.integer  "flight_number"
    t.string   "departure_location"
    t.string   "arrival_location"
    t.decimal  "price",              precision: 8, scale: 2
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "flights", ["arrival_location"], name: "index_flights_on_arrival_location"
  add_index "flights", ["departure_date"], name: "index_flights_on_departure_date"
  add_index "flights", ["departure_location"], name: "index_flights_on_departure_location"

  create_table "passengers", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_hash"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

end
