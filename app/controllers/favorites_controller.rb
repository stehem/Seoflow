class FavoritesController < ApplicationController

def create
  user = User.find(session[:id])
  if @fav = Favorite.find_by_user_id_and_question_id(session[:id],  params[:question_id])
    @fav.destroy
    @unfav = 1
  else
    user.favorites.create(:question_id => params[:question_id])
    item = Question.find(params[:question_id])
    poster = item.user
    Badge.favorites(item, poster)
  end
end

def index
  if session[:id]
    favorites = Favorite.find_all_by_user_id(session[:id])
    favorites.inject(a = []) {|a,f| a << f.question_id}
    @favorites = Question.find(a)
    @active = "Favoris"
  else
    redirect_to new_session_path
  end
end

end
