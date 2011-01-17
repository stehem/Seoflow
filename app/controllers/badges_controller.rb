class BadgesController < ApplicationController

def index
  @badges = Badgelist.find(:all)
end

def show
@badge = Badgelist.find(params[:id])
users = Badge.find(:all, :select => :user_id, :conditions => {:badge_name => @badge.badge_name})
users.inject(a=[]) {|a,f| a << f.user_id}
@users = User.find(a, :include => :badges, :conditions => ["badges.badge_name = ?", @badge.badge_name])
end



end
