class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :login
      t.string :identifier
      t.string :encrypted_password
      t.string :salt
      t.string :password
      t.integer :sum_of_karma, :default => 0
      t.integer :sum_of_bronze, :default => 0
      t.integer :sum_of_silver, :default => 0
      t.integer :sum_of_gold, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
