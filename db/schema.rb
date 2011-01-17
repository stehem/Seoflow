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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110117191124) do

  create_table "answers", :force => true do |t|
    t.text     "body"
    t.integer  "user_id"
    t.integer  "question_id"
    t.integer  "solved",       :default => 0
    t.integer  "sum_of_votes", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "badgelists", :force => true do |t|
    t.string   "badge_name"
    t.text     "badge_desc"
    t.string   "metal"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "badges", :force => true do |t|
    t.integer  "user_id"
    t.string   "badge_name"
    t.string   "metal"
    t.integer  "answer_id"
    t.integer  "question_id"
    t.integer  "badgeid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "favorites", :force => true do |t|
    t.integer  "question_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "karmas", :force => true do |t|
    t.integer  "user_id"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notifiers", :force => true do |t|
    t.integer  "user_id"
    t.string   "badge_name"
    t.string   "metal"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "badgeid"
  end

  create_table "questions", :force => true do |t|
    t.text     "title"
    t.text     "body"
    t.integer  "user_id"
    t.integer  "views",        :default => 0
    t.integer  "solved",       :default => 0
    t.integer  "sum_of_votes", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "replies", :force => true do |t|
    t.text     "body"
    t.integer  "user_id"
    t.integer  "answer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_name"
  end

  create_table "tags", :force => true do |t|
    t.string   "tag"
    t.integer  "question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "identifier"
    t.string   "encrypted_password"
    t.string   "salt"
    t.integer  "sum_of_karma",       :default => 0
    t.integer  "sum_of_bronze",      :default => 0
    t.integer  "sum_of_silver",      :default => 0
    t.integer  "sum_of_gold",        :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "email"
    t.string   "realname"
    t.string   "website"
    t.string   "age"
    t.string   "ville"
    t.integer  "views",              :default => 0
    t.text     "bio"
  end

  create_table "votes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.integer  "answer_id"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
