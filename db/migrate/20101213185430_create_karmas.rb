class CreateKarmas < ActiveRecord::Migration
  def self.up
    create_table :karmas do |t|
      t.integer :user_id
      t.integer :value

      t.timestamps
    end
  end

  def self.down
    drop_table :karmas
  end
end
