# encoding: UTF-8
class UserController < ApplicationController

respond_to :html, :js

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.local = "true"
    @user.encrypt_password
      if @user.save 
        flash[:message] = "Utilisateur créé, vous pouvez maintenant vous  connecter"
        redirect_to new_session_path
      end
  end

def show
  @user = User.find(params[:id])
  @questions = @user.questions
  @questions_total = @questions.size
  @paginated_questions = @questions.paginate(:all, :order => "created_at DESC", :per_page => 10, :page => params[:page])
  @answers = @user.answers
  @answers2 = Answer.paginate(:all, :order => "created_at DESC", :per_page => 10, :page => params[:page], :conditions => {:user_id => @user.id}, :include => :question)
  @vote_counts = Vote.count(:group => :value, :conditions => {:user_id => @user.id})
  @answers.inject(arr=[]) {|arr,f| arr << f.question_id}
  @tags_counts = Tag.count(:group => :tag, :conditions => {:question_id => arr}).sort {|a,b| b[1]<=>a[1]}
  @user.increment!(:views)
  @a = Badge.count(:group => :badgeid, :conditions => {:user_id => @user.id})
  @b = Badgelist.find(@a.keys)
  @title = @user.name
  @desc = "Page profil de " + @user.name + " sur SEOFlow."
  @robots='INDEX,FOLLOW'
  
end

def index
 @users = User.paginate(:all, :per_page => 40, :page => params[:page], :order => "sum_of_karma DESC")
end

def edit
 @user = User.find(params[:id])
end

def update
  @user = User.find(params[:id])
  if session[:id] == @user.id
    attrib = [:realname, :website, :ville, :age, :email, :bio]
    attrib.each do |f|
      @user[f] = Sanitize.clean(params[:user][f], Sanitize::Config::RESTRICTED)
    end
    @user.upd = "true"
    @user.update_attributes!(attrib)
    redirect_to @user
  end
end
                                   	
def validate_user_name
  name = params[:user][:name].strip.downcase
  user = User.find(:first, :conditions => ["lower(name) = ?", name])
  user ? (render :json => "false") : (render :json => "true")
end

end
