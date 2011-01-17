class Reply < ActiveRecord::Base
belongs_to :answer
belongs_to :user
validates_presence_of :body
require 'sanitize'

attr_accessible :body

def cleaner
 self.body = Sanitize.clean(self.body,
    :elements => ['a'],
    :attributes => {'a' => ['href']},
    :protocols => {'a' => {'href' => ['http']}},
    :add_attributes => {'a' => {'rel' => 'nofollow'}})
end

end
