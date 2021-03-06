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

ActiveRecord::Schema.define(version: 20171124031330) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "provider"
    t.string "uid"
    t.integer "authority", default: 0, null: false
    t.string "password_digest", null: false
  end

  create_table "word_that_the_user_learneds", force: :cascade do |t|
    t.integer "user_id"
    t.integer "word_id"
    t.integer "challenge_count"
    t.integer "status", default: 0, null: false
  end

  create_table "words", force: :cascade do |t|
    t.string "japanese"
    t.string "english"
    t.string "meaning"
    t.integer "category", default: 0, null: false
  end

end
