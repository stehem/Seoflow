class CreateBadges < ActiveRecord::Migration
  def self.up
    create_table :badges do |t|
      t.integer :user_id
      t.string :badge_name
      t.string :metal
      t.integer :answer_id
      t.integer :question_id
      t.integer :badgeid

      t.timestamps
    end
  end

  def self.down
    drop_table :badges
  end
end
