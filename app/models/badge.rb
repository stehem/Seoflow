# coding: utf-8

class Badge < ActiveRecord::Base
belongs_to :user


#################### master   up & down votes

def self.upvote_global(user,poster,item)
nb_of_upvotes = Vote.sum('value', :conditions => {:user_id => user.id, :value => 1})
  if nb_of_upvotes == 0
    user.increment!(:sum_of_bronze, by = 1)
    badge = Badge.create(:user_id => user.id, :badge_name => "Supporter", :metal => "Bronze", :badgeid => 1)
    badge.badge_name
  elsif nb_of_upvotes == 14
    user.increment!(:sum_of_silver, by = 1)
    badge = Badge.create(:user_id => user.id, :badge_name => "Devoir Civique", :metal => "Argent", :badgeid => 2)
    badge.badge_name
  else 
    nil
  end
end

def self.downvote_global(user,poster,item)
nb_of_downvotes = Vote.sum('value', :conditions => {:user_id => user.id, :value => -1}) 
  if nb_of_downvotes == 0
    user.increment!(:sum_of_bronze, by = 1)
    badge = Badge.create(:user_id => user.id, :badge_name => "Critique", :metal => "Bronze", :badgeid => 3)
    badge.badge_name
  else
    nil
  end
end





#################### upvotes received

def self.upvotes_received(item,poster)
  if item.class.name == "Question"
    if item.sum_of_votes == 0 && !Badge.find_by_user_id(poster.id, :conditions => {:badge_name => "Étudiant"})
      Badge.create(:user_id => poster.id, :badge_name => "Étudiant", :metal => "Bronze", :badgeid => 4)
      Notifier.create(:user_id => poster.id, :badge_name => "Étudiant", :metal => "Bronze")
      poster.increment!(:sum_of_bronze, by = 1)
    elsif item.sum_of_votes == 2 && !Badge.find_by_user_id_and_question_id(poster.id,item.id, :conditions => {:badge_name => "Bonne Question"})
      Badge.create(:user_id => poster.id, :question_id => item.id, :badge_name => "Bonne Question", :metal => "Bronze", :badgeid => 5)
      Notifier.create(:user_id => poster.id, :badge_name => "Bonne Question", :metal => "Bronze")
      poster.increment!(:sum_of_bronze, by = 1)
    elsif item.sum_of_votes == 4 && !Badge.find_by_user_id_and_question_id(poster.id,item.id, :conditions => {:badge_name => "Très Bonne Question"})
      Badge.create(:user_id => poster.id, :question_id => item.id, :badge_name => "Très Bonne Question", :metal => "Silver", :badgeid => 6)
      Notifier.create(:user_id => poster.id, :badge_name => "Très Bonne Question", :metal => "Silver")
      poster.increment!(:sum_of_silver, by = 1)
    elsif item.sum_of_votes == 7 && !Badge.find_by_user_id_and_question_id(poster.id,item.id, :conditions => {:badge_name => "Excellente Question"})    
      Badge.create(:user_id => poster.id, :question_id => item.id, :badge_name => "Excellente Question", :metal => "Gold", :badgeid => 7)
      Notifier.create(:user_id => poster.id, :badge_name => "Excellente Question", :metal => "Gold")
      poster.increment!(:sum_of_gold, by = 1)
    end
  elsif item.class.name == "Answer"
    if item.sum_of_votes == 2 && !Badge.find_by_user_id_and_answer_id(poster.id, item.id, :conditions => {:badge_name => "Bonne Réponse"})
      Badge.create(:user_id => poster.id, :answer_id => item.id, :badge_name => "Bonne Réponse", :metal => "Bronze", :badgeid => 8)
      Notifier.create(:user_id => poster.id, :badge_name => "Bonne Réponse", :metal => "Bronze")
      poster.increment!(:sum_of_bronze, by = 1)
    elsif item.sum_of_votes == 4 && !Badge.find_by_user_id_and_answer_id(poster.id,item.id, :conditions => {:badge_name => "Très Bonne Réponse"})
      Badge.create(:user_id => poster.id, :answer_id => item.id, :badge_name => "Très Bonne Réponse", :metal => "Silver", :badgeid => 9)
      Notifier.create(:user_id => poster.id, :badge_name => "Très Bonne Réponse", :metal => "Silver")
      poster.increment!(:sum_of_silver, by = 1)
    elsif item.sum_of_votes == 7 && !Badge.find_by_user_id_and_answer_id(poster.id,item.id, :conditions => {:badge_name => "Excellente Réponse"})    
      Badge.create(:user_id => poster.id, :answer_id => item.id, :badge_name => "Excellente Réponse", :metal => "Gold", :badgeid => 10)
      Notifier.create(:user_id => poster.id, :badge_name => "Excellente Réponse", :metal => "Gold")
      poster.increment!(:sum_of_gold, by = 1)
    end
  end
end

#################### edit

def self.first_edit(user)
  if !Badge.find_by_user_id(user.id, :conditions => {:badge_name => "Éditeur"})
    badge = Badge.create(:user_id => user.id, :badge_name => "Éditeur", :metal => "Bronze", :badgeid => 11)
    user.increment!(:sum_of_bronze, by = 1)
    badge.badge_name
  else
    nil
  end
end


#################### destroy

def self.delete(user,item)
  if item.sum_of_votes <= -3 && !Badge.find_by_user_id(user.id, :conditions => {:badge_name => "Pression Externe"})
    badge = Badge.create(:user_id => user.id, :badge_name => "Pression Externe", :metal => "Silver", :badgeid => 12)
    user.increment!(:sum_of_silver, by = 1)
    badge.badge_name
  elsif !Badge.find_by_user_id(user.id, :conditions => {:badge_name => "Nettoyeur"})
    badge = Badge.create(:user_id => user.id, :badge_name => "Nettoyeur", :metal => "Bronze", :badgeid => 13)
    user.increment!(:sum_of_bronze, by = 1)
    badge.badge_name
  else
    nil
  end
end

#################### accepted answers

def self.accepted_answer(item,poster)
  if item.sum_of_votes > 0 && item.sum_of_votes < 3 && !Badge.find_by_user_id_and_answer_id(poster.id, item.id, :conditions => {:badge_name => "Prof"})
    Badge.create(:user_id => poster.id, :badge_name => "Prof", :metal => "Bronze", :badgeid => 14)
    Notifier.create(:user_id => poster.id, :answer_id => item.id, :badge_name => "Prof", :metal => "Bronze")
    poster.increment!(:sum_of_bronze, by = 1)
  elsif item.sum_of_votes > 2 && item.sum_of_votes < 5 && !Badge.find_by_user_id_and_answer_id(poster.id, item.id, :conditions => {:badge_name => "Éclairé"})
    Badge.create(:user_id => poster.id, :answer_id => item.id, :badge_name => "Éclairé", :metal => "Silver", :badgeid => 15)
    Notifier.create(:user_id => poster.id, :badge_name => "Éclairé", :metal => "Silver")
    poster.increment!(:sum_of_silver, by = 1)
  elsif item.sum_of_votes > 4  && !Badge.find_by_user_id_and_answer_id(poster.id, item.id, :conditions => {:badge_name => "Guru"})
    Badge.create(:user_id => poster.id, :answer_id => item.id, :badge_name => "Guru", :metal => "Gold", :badgeid => 16)
    Notifier.create(:user_id => poster.id, :badge_name => "Guru", :metal => "Gold")
    poster.increment!(:sum_of_gold, by = 1)
  end
end


#################### view count

def self.view_count(item, poster)
  if item.views == 100
    Badge.create(:user_id => poster.id, :badge_name => "Question Populaire", :metal => "Bronze")
    Notifier.create(:user_id => poster.id, :badge_name => "Question Populaire", :metal => "Bronze", :badgeid => 17)
    poster.increment!(:sum_of_bronze, by = 1)
  elsif item.views == 250 
    Badge.create(:user_id => poster.id, :badge_name => "Question Fameuse", :metal => "Silver")
    Notifier.create(:user_id => poster.id, :badge_name => "Question Fameuse", :metal => "Silver", :badgeid => 18)
    poster.increment!(:sum_of_silver, by = 1)
  elsif item.views == 500 
    Badge.create(:user_id => poster.id, :badge_name => "Question Célèbre", :metal => "Gold")
    Notifier.create(:user_id => poster.id, :badge_name => "Question Célèbre", :metal => "Gold", :badgeid => 19)
    poster.increment!(:sum_of_gold, by = 1)
  end
end


#################### favorites


def self.favorites(item, poster)
  a = Favorite.count(:conditions => {:question_id => item.id})
  if a > 0 && a < 3 && !Badge.find_by_user_id_and_question_id(poster.id, item.id, :conditions => {:badge_name => "Question Favorite"})
    Badge.create(:user_id => poster.id, :question_id => item.id, :badge_name => "Question Favorite", :metal => "Bronze", :badgeid => 20)
    Notifier.create(:user_id => poster.id, :badge_name => "Question Favorite", :metal => "Bronze")
    poster.increment!(:sum_of_bronze, by = 1)
  elsif a > 2 && !Badge.find_by_user_id_and_question_id(poster.id, item.id, :conditions => {:badge_name => "Question Stellaire"})
    Badge.create(:user_id => poster.id, :question_id => item.id, :badge_name => "Question Stellaire", :metal => "Silver", :badgeid => 21)
    Notifier.create(:user_id => poster.id, :badge_name => "Question Stellaire", :metal => "Silver")
    poster.increment!(:sum_of_silver, by = 1)
  end
end


#################### replies

def self.replies(user)
  if Reply.count(:conditions => {:user_id => user.id}) > 9 && !Badge.find_by_user_id(user.id, :conditions => {:badge_name => "Précision"})
    badge = Badge.create(:user_id => user.id, :badge_name => "Précision", :metal => "Bronze", :badgeid => 22)
    user.increment!(:sum_of_bronze, by = 1)
    badge.badge_name
  else
    nil
 end
end



end




