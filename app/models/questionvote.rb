class Questionvote < ActiveRecord::Base
belongs_to :question

def self.voting_on_own_question(user, poster)
user.id == poster.id
end


end
