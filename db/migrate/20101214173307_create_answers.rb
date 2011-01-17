class CreateAnswers < ActiveRecord::Migration
  def self.up
    create_table :answers do |t|
      t.text :body
      t.integer :user_id
      t.integer :question_id
      t.integer :solved, :default => 0
      t.integer :sum_of_votes, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :answers
  end
end
