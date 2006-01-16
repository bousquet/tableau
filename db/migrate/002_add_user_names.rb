class AddUserNames < ActiveRecord::Migration
  def self.up
    STDERR.puts "Adding first and last names to users table"
    add_column :users, :first, :string, :default=>""
    add_column :users, :last, :string, :default=>""
  end

  def self.down
    STDERR.puts "Removing first and last name columns from user table"
    remove_column :users, :first
    remove_column :users, :first
  end
end
