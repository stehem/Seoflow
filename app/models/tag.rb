class Tag < ActiveRecord::Base
belongs_to :question
validates_presence_of :tag
validates_length_of :tag, :maximum=>30

end
