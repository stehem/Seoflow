class AddUserNameToReply < ActiveRecord::Migration
  def self.up
    add_column :replies, :user_name, :string
  end

  def self.down
    remove_column :replies, :user_name
  end
end
