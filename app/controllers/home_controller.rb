class HomeController < ApplicationController
respond_to :html,:js

def index
  if @tags = params[:tag]
    Tag.find(:all, :conditions => {:tag => params[:tag]}).inject(arr=[]) {|arr,f| arr << f.question_id}  
    @questions = Question.paginate(arr , :order => "created_at DESC", :include => [:answers, :tags], :page => params[:page] || 1, :per_page => 17)  
  elsif params[:filter] == "date"
    @questions = Question.paginate(:all, :order => "created_at DESC", :include => [:answers, :tags], :page => params[:page] || 1, :per_page => 17)  
    @active = "Date"
  elsif params[:filter] == "votes"
    @questions = Question.paginate(:all, :order => "sum_of_votes DESC", :include => [:answers, :tags], :page => params[:page] || 1, :per_page => 17)  
    @active = "Votes"
  else
    @questions = Question.find(:all, :include => [:answers, :tags])
    @questions.sort! do |q1, q2| 
      q2.answers.blank? ? b = q2.created_at : b = q2.answers.last.created_at
      q1.answers.blank? ? a = q1.created_at : a = q1.answers.last.created_at
      b <=> a
    end
    @questions = @questions.paginate(:page => params[:page] || 1, :per_page => 17)
    @active = "Activité"
  end
  @tags_counts =  Tag.count(:group => :tag, :limit => 10)
  @recent_badges = Badge.find(:all, :order => "created_at DESC", :limit => 10, :include => :user)
  @users = User.all(:order => 'created_at DESC', :limit => 5)
  params[:page] || params[:tag] || params[:filter]? @robots='NOINDEX,FOLLOW' : @robots='INDEX,FOLLOW'  
  @canonical = '<link rel="canonical" href="http://www.seoflow.fr' + root_path + '">' unless params[:page] || params[:tag]
end

def faq
end

end




