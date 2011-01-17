class AddBadgeidToNotifier < ActiveRecord::Migration
  def self.up
    add_column :notifiers, :badgeid, :integer
  end

  def self.down
    remove_column :notifiers, :badgeid
  end
end
