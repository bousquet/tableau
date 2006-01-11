# This file is autogenerated. Instead of editing this file, please use the
# migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.

ActiveRecord::Schema.define(:version => 1) do

  create_table "albums", :force => true do |t|
    t.column "user_id", :integer
    t.column "title", :string
    t.column "created_at", :datetime
    t.column "position", :integer
  end

  create_table "albums_photos", :id => false, :force => true do |t|
    t.column "album_id", :integer
    t.column "photo_id", :integer
  end

  create_table "photos", :force => true do |t|
    t.column "user_id", :integer
    t.column "title", :string
    t.column "position", :integer
    t.column "created_at", :datetime
    t.column "taken_at", :datetime
  end

  create_table "sessions", :force => true do |t|
    t.column "session_id", :string
    t.column "data", :text
    t.column "updated_at", :datetime
  end

  add_index "sessions", ["session_id"], :name => "sessions_session_id_index"

  create_table "users", :force => true do |t|
    t.column "login", :string
    t.column "email", :string
    t.column "crypted_password", :string
    t.column "salt", :string
    t.column "activation_code", :string
    t.column "activated_at", :datetime
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
  end

end
