class AnswersController < ApplicationController
respond_to :js#,:html

def create
user = User.find(session[:id])
@question = Question.find(params[:answer][:question_id])
@answer = user.answers.new(params[:answer])
@answer.cleaner
@answer.save

       #redirect_to @question
  #else
    #render :template => "questions/show" 
 
end

def edit
@answer = Answer.find(params[:id])
end

def update
@answer = Answer.find(params[:id])
if @answer.user.id == session[:id]
  @answer.update_attribute(:body, params[:answer][:body])
  @badge = Badge.first_edit(@answer.user)
end
end


def destroy
@answer = Answer.find(params[:id])
if @answer.user.id == session[:id]
  @answer.destroy
  @badge = Badge.delete(@answer.user,@answer)
end
end



end

