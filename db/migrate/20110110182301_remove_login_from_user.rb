class RemoveLoginFromUser < ActiveRecord::Migration
  def self.up
    remove_column :users, :login
    remove_column :users, :password
  end

  def self.down
    add_column :users, :login, :string
  end
end
