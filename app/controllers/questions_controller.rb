class QuestionsController < ApplicationController

respond_to :html,:js


def new
  @question = Question.new
#respond_with(@tags = Tag.all.map { |x| x.tag })
  redirect_to new_session_path unless session[:login]
end

def create
user = User.find(session[:id])
@question = user.questions.new(params[:question])
@question.cleaner
  if @question.save
    respond_with(@question)
    [params[:tag1], params[:tag2], params[:tag3]].each do |f|
      @question.tags.create(:tag => format_tags(f))
    end
  else
    render :new
  end
end

def show 
@question = Question.find(params[:id] , :include => [:user, {:answers => [:user, {:replies => :user}]}, :tags] )
tags =  @question.tags.inject([]) {|a,f| a << f.tag}
@similars = Tag.all(:conditions => ["tag IN (:tags)", {:tags => tags}], :include => :question)

respond_with(@question,@answer = Answer.new, @fav = Favorite.find_by_user_id_and_question_id(session[:id],  @question.id), @similars,@title = @question.title,@desc = @question.title,@robots='INDEX,FOLLOW')
@question.update_attribute(:views , @question.views + 1)
Badge.view_count(@question, @question.user)


end

def solved
  @question = Question.find(params[:id])
  if @question.user.id == session[:id]
    @question.update_attribute(:solved, params[:answer_id])
    @answer = Answer.find(params[:answer_id])
    @answer.update_attribute(:solved, "1")
    Badge.accepted_answer(@answer,@answer.user)
  end
end

def edit
  @question = Question.find(params[:id])
end

def update
  @question = Question.find(params[:id])
  if @question.user.id == session[:id]
    @question.update_attribute(:body, params[:question][:body])
    @badge = Badge.first_edit(@question.user)
  end
end

def index
  @results = Question.search(params[:search]).paginate(:order => "created_at DESC", :per_page => 10, :page => params[:page])
end



end



