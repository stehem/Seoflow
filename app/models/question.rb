class Question < ActiveRecord::Base
require 'sanitize'
require 'unicode'

has_many :answers
has_many :replies, :through => :answers
has_many :votes
has_many :questionvotes
has_many :tags
belongs_to :user
validates_presence_of :title,:body


attr_accessible :body, :title

index do
  title
end




def cleaner
 self.title = Sanitize.clean(self.title, Sanitize::Config::RESTRICTED)
 self.body = Sanitize.clean(self.body,
    :elements => ['a', 'strong','em','p','ul','li','blockquote'],
    :attributes => {'a' => ['href']},
    :protocols => {'a' => {'href' => ['http']}},
    :add_attributes => {'a' => {'rel' => 'nofollow'}})
end

def to_param
  "#{id}#{Unicode::normalize_KD("-"+title).downcase.gsub(/[^a-z0-9\s_-]+/,'').gsub(/[\s_-]+/,'-')[0..100].chomp("-")}"
end 

end





