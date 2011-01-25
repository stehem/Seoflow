class AutocompleteController < ApplicationController

respond_to :js

def autocomplete
query = "%#{params[:term]}%"
@tags = Tag.find(:all, :conditions => ["tag LIKE ?", query] , :select => "tag", :group => :tag)  
render :json => map_tags(@tags)
end


def map_tags(items)
items.collect {|i| {"label" => i.tag, "value" => i.tag}}
end

def tags_search
query = "%#{params[:filter]}%"
if params[:filter].blank?
  @tags = Tag.count(:group => :tag, :conditions => ["tag LIKE ?", "-"], :order => 'count(tag) DESC').to_a.paginate(:per_page => 40, :page => params[:page])
else
  @tags = Tag.count(:group => :tag, :conditions => ["tag LIKE ?", query], :order => 'count(tag) DESC').to_a.paginate(:per_page => 40, :page => params[:page])
end
end

def users_search
query = "%#{params[:filter]}%"
if params[:filter].blank?
  @users = User.paginate(:all, :per_page => 40, :page => params[:page], :order => "sum_of_karma DESC")
else
  @users = User.find(:all, :conditions => ["name iLIKE ?", query])
end
end

end



