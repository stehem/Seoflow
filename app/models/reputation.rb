class Reputation < ActiveRecord::Base
belongs_to :user

def self.max_pos_karma_per_day(poster)
Reputationbyvote.sum(:karma_added, :conditions => ["created_at > ? AND user_id = ?", 24.hours.ago, poster.id]) <= 100
end

def self.max_neg_karma_per_day(poster)
Reputationbyvote.sum(:karma_added, :conditions => ["created_at > ? AND user_id = ?", 24.hours.ago, poster.id]) >= -50
end

def self.vote_up_question(poster)
  rep = self.find_by_user_id(poster.id)
  rep.update_attribute(:karma, rep.karma + 10)  
  Reputationbyvote.new(:user_id => poster.id, :karma_added => 10).save
end

def self.vote_down_question(poster)
  rep = self.find_by_user_id(poster.id)
  rep.update_attribute(:karma, rep.karma - 5)  
  Reputationbyvote.new(:user_id => poster.id, :karma_added => -5).save
end

def self.vote_up_answer(answer_id)
  q = Answer.find(answer_id)
  u = q.user
  rep = self.find_by_user_id(u.id)
  rep.update_attribute(:karma, rep.karma + 10)  
end

def self.vote_down_answer(answer_id)
  q = Answer.find(answer_id)
  u = q.user
  rep = self.find_by_user_id(u.id)
  rep.update_attribute(:karma, rep.karma - 5)  
end


end

