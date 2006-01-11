class InitialSchema < ActiveRecord::Migration
  def self.up
    
    STDERR.puts "Creating albums table"
    create_table :albums do |t|
      t.column :user_id, :integer
      t.column :title, :string
      t.column :created_at, :datetime
      t.column :position, :integer
    end
    
    STDERR.puts "Creating albums_photos join table"
    create_table :albums_photos, :id=>false do |t|
      t.column :album_id, :integer
      t.column :photo_id, :integer
    end
    
    STDERR.puts "Creating photos table"
    create_table :photos do |t|
      t.column :user_id, :integer
      t.column :title, :string
      t.column :position, :integer
      t.column :created_at, :datetime
      t.column :taken_at, :datetime
    end
    
    STDERR.puts "Creating sessions table"
    create_table :sessions do |t|
      t.column :session_id, :string
      t.column :data, :text
      t.column :updated_at, :datetime
    end

    add_index :sessions, ["session_id"], :name => "sessions_session_id_index"
    
    STDERR.puts "Creating user table"
    create_table :users do |t|
      t.column :login,            :string
      t.column :email,            :string
      t.column :crypted_password, :string
      t.column :salt,             :string
      t.column :activation_code,  :string   # only if you want
      t.column :activated_at,     :datetime # user activation
      t.column :created_at,       :datetime
      t.column :updated_at,       :datetime
    end
    
  end

  def self.down
    
    STDERR.puts "Dropping photos table"
    drop_table :photos
    STDERR.puts "Dropping sessions table"
    drop_table :sessions
    STDERR.puts "Dropping sets table"
    drop_table :albums
    STDERR.puts "Dropping albums_photos join table"
    drop_table :albums_photos
    STDERR.puts "Dropping user table"
    drop_table :users
    
  end
end
