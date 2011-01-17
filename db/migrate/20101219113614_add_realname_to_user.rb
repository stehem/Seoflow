class AddRealnameToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :realname, :string
    add_column :users, :website, :string
    add_column :users, :age, :string
    add_column :users, :ville, :string

  end

  def self.down
    remove_column :users, :realname
  end
end
