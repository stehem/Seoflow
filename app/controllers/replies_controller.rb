class RepliesController < ApplicationController
respond_to :js

def create
return unless user = User.find(session[:id])
@answer = Answer.find(params[:answer_id])
@reply = @answer.replies.build(params[:reply])
@reply.cleaner
@reply.user_id, @reply.user_name = user.id, user.name
@reply.save
respond_with(@reply,@badge = Badge.replies(user))
end


end
