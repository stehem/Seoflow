class CreateBadgelists < ActiveRecord::Migration
  def self.up
    create_table :badgelists do |t|
      t.string :badge_name
      t.text :badge_desc
      t.string :metal

      t.timestamps
    end
  end

  def self.down
    drop_table :badgelists
  end
end
