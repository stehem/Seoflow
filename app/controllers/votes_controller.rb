class VotesController < ApplicationController
respond_to :js



def create

if session[:id]
  if params[:item] == "question"
    @item = "question"
    user = User.find(session[:id])
    @question = Question.find(params[:question_id])
    poster = @question.user
      #if !Vote.has_voted_already_question(@question.id, user)
        #if !Vote.voting_on_self(poster.id, user.id)
          if params[:pos] == "true"
            @badge = Badge.upvote_global(user,poster,@question)
<<<<<<< HEAD
            Badge.upvotes_received(@question,poster)
=======
>>>>>>> 27030f05a1d66049283945d1af22a649a73781e4
            Vote.create(:question_id => params[:question_id], :user_id => user.id, :value => 1)
            @question.increment!(:sum_of_votes, by = 1)
            @flag = "OK"
              if Karma.max_pos_karma_per_day(poster)
                Karma.create(:user_id => poster.id, :value => 10)
                poster.increment!(:sum_of_karma, by = 10)
              end
          elsif params[:neg] == "true"
            @badge = Badge.downvote_global(user,poster,@question)
            Vote.create(:question_id => params[:question_id], :user_id => user.id, :value => -1)
            @question.increment!(:sum_of_votes, by = -1)
            @flag = "OK"
              if Karma.max_neg_karma_per_day(poster)
                Karma.create(:user_id => poster.id, :value => -5)
		poster.increment!(:sum_of_karma, by = -5)
              end
          end
        #else
          #@flag = "self_voting"
        #end
      #else
        #@flag = "already_voted"
      #end
  elsif params[:item] == "answer"
    @item = "answer"
    user = User.find(session[:id])
    @answer = Answer.find(params[:answer_id])
    poster = @answer.user  
      #if !Vote.has_voted_already_answer(@answer.id, user)
        #if !Vote.voting_on_self(poster.id, user.id)
          if params[:pos] == "true"
            @badge = Badge.upvote_global(user,poster,@answer)
<<<<<<< HEAD
            Badge.upvotes_received(@answer,poster)
=======
>>>>>>> 27030f05a1d66049283945d1af22a649a73781e4
            Vote.create(:answer_id => params[:answer_id], :user_id => user.id, :value => 1)
            @answer.increment!(:sum_of_votes, by = 1)
            @flag = "OK"
              if Karma.max_pos_karma_per_day(poster)
                Karma.new(:user_id => poster.id, :value => 10).save
                poster.increment!(:sum_of_karma, by = 10)
              end
          elsif params[:neg] == "true"
            @badge = Badge.downvote_global(user,poster,@answer)
            Vote.create(:answer_id => params[:answer_id], :user_id => user.id, :value => -1)
            @answer.increment!(:sum_of_votes, by = -1)
            @flag = "OK"
              if Karma.max_neg_karma_per_day(poster)
                Karma.new(:user_id => poster.id, :value => -5).save
		poster.increment!(:sum_of_karma, by = -5)
              end
          end
  end
        #else
          #@flag = "self_voting"
        #end
      #else
        #@flag = "already_voted"
      #end
else
  if params[:item] == "question"
    @item = "question"
  elsif params[:item] == "answer"
    @item = "answer"
    @answer_id = params[:answer_id]
  end
  @flag = "not_logged_in"
end

end

##

end
