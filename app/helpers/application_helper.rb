module ApplicationHelper

def nb_of_answers(d,f)
  if d >= 1
    " answered-accepted"
  else
    if f >= 1
      " answered"
    elsif f == 0
      " unanswered"
    end
  end
end

def answer_has_replies(f)
  if !f
    ' has_no_answers'
  end
end

def sum_attr(big_array)
  small_array = []
  big_array.each do |f|
    small_array << f.value
  end
  @sum = small_array.sum
end


def avatar_url(user,large = 0)  
  large == 1 ? size = 96 : size = 28
  if user.email
    gravatar_id = Digest::MD5::hexdigest(user.email).downcase  
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"  
  else
    "http://gravatar.com/avatar/#{rand(10)}?s=#{size}&d=identicon"
  end
end  



end
