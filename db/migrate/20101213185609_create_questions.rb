class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.text :title
      t.text :body
      t.integer :user_id
      t.integer :views, :default => 0
      t.integer :solved, :default => 0
      t.integer :sum_of_votes, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :questions
  end
end
