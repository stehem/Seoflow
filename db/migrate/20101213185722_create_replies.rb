class CreateReplies < ActiveRecord::Migration
  def self.up
    create_table :replies do |t|
      t.text :body
      t.integer :user_id
      t.integer :answer_id

      t.timestamps
    end
  end

  def self.down
    drop_table :replies
  end
end
