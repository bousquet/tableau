class AddUserNames < ActiveRecord::Migration
  def self.up
    STDERR.puts "Adding first and last names to users table"
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
  end

  def self.down
    STDERR.puts "Removing first and last name columns from user table"
    remove_column :users, :first_name
    remove_column :users, :last_name
  end
end
