class Answer < ActiveRecord::Base
belongs_to :question
belongs_to :user 
has_many :replies
has_many :votes
validates_presence_of :body
require 'sanitize'

attr_accessible :question_id, :body


def cleaner
 self.body = Sanitize.clean(self.body,
<<<<<<< HEAD
    :elements => ['a', 'strong','em','p','ul','ol','li','blockquote'],
=======
    :elements => ['a', 'strong','em','p','ul','li','blockquote'],
>>>>>>> 27030f05a1d66049283945d1af22a649a73781e4
    :attributes => {'a' => ['href']},
    :protocols => {'a' => {'href' => ['http']}},
    :add_attributes => {'a' => {'rel' => 'nofollow'}})
end


end
