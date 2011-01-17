class Karma < ActiveRecord::Base
belongs_to :user

def self.max_pos_karma_per_day(poster)
self.sum(:value, :conditions => ["created_at > ? AND user_id = ?", 24.hours.ago, poster.id]) <= 100
end

def self.max_neg_karma_per_day(poster)
self.sum(:value, :conditions => ["created_at > ? AND user_id = ?", 24.hours.ago, poster.id]) >= -50
end

end
