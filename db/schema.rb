# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 2) do

  create_table "albums", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.datetime "created_at"
    t.integer  "position"
  end

  create_table "albums_photos", :id => false, :force => true do |t|
    t.integer "album_id"
    t.integer "photo_id"
  end

  create_table "photos", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "taken_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id"
    t.text     "data"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "sessions_session_id_index"

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.string   "activation_code"
    t.datetime "activated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
  end

end
