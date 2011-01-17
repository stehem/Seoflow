class CreateLalalas < ActiveRecord::Migration
  def self.up
    drop_table :badgelists
    end
  

  def self.down
    drop_table :lalalas
  end
end
