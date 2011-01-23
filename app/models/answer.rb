class Answer < ActiveRecord::Base
belongs_to :question
belongs_to :user 
has_many :replies
has_many :votes
validates_presence_of :body
require 'sanitize'

attr_accessible :question_id, :body

def self.clean_param(p)
  Sanitize.clean(p,
    :elements => ['a', 'strong','em','p','ul','ol','li','blockquote'],
    :attributes => {'a' => ['href']},
    :protocols => {'a' => {'href' => ['http']}},
    :add_attributes => {'a' => {'rel' => 'nofollow'}})
end


def cleaner
 self.body = Sanitize.clean(self.body,
    :elements => ['a', 'strong','em','p','ul','ol','li','blockquote'],
    :attributes => {'a' => ['href']},
    :protocols => {'a' => {'href' => ['http']}},
    :add_attributes => {'a' => {'rel' => 'nofollow'}})
end


end
