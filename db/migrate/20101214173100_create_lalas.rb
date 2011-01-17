class CreateLalas < ActiveRecord::Migration
  def self.up
    drop_table :answers
    end


  def self.down
    drop_table :lalas
  end
end
