class Vote < ActiveRecord::Base
belongs_to :user
belongs_to :question
belongs_to :answer


def self.has_voted_already_question(question_id, user)
Vote.find_by_question_id(question_id, :conditions => {:user_id => user.id})
end

def self.voting_on_self(poster_id, user_id)
poster_id == user_id
end


def self.has_voted_already_answer(answer_id, user)
Vote.find_by_answer_id(answer_id, :conditions => {:user_id => user.id})
end



end
