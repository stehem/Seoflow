class CreateNotifiers < ActiveRecord::Migration
  def self.up
    create_table :notifiers do |t|
      t.integer :user_id
      t.string :badge_name
      t.string :metal

      t.timestamps
    end
  end

  def self.down
    drop_table :notifiers
  end
end
