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

ActiveRecord::Schema.define(version: 20180326195047) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "topics", force: :cascade do |t|
    t.string "querytext"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tweets", force: :cascade do |t|
    t.bigint "topic_id"
    t.string "author"
    t.string "body"
    t.integer "retweets"
    t.integer "favs"
    t.datetime "posted_on"
    t.bigint "twitter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["topic_id"], name: "index_tweets_on_topic_id"
    t.index ["twitter_id"], name: "index_tweets_on_twitter_id", unique: true
  end

  add_foreign_key "tweets", "topics"
end
