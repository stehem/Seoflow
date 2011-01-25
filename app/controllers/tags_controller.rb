class TagsController < ApplicationController
respond_to :html , :js
 

  def index
    @tags = Tag.count(:group => :tag).to_a.paginate(:per_page => 40, :page => params[:page])
  end

end



