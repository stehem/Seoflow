class SearchController < ApplicationController

def show
  @user,@tag = User.find(params[:id]),params[:tag]
  @answers = @user.answers
  @answers.inject(arr=[]) {|arr,f| arr << f.question_id}
  tags = Tag.find(:all, :conditions => { :tag => params[:tag]})
  tags.inject(arr1=[]) {|arr1,f| arr1 << f.question_id}
  @questions = Question.paginate(arr & arr1, :order => "created_at DESC", :per_page => 10, :page => params[:page])

end


end 
