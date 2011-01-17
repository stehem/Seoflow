# encoding: UTF-8
class SessionsController < ApplicationController

def new
@session = Session.new
end

def rpx_token
    raise ActionController::Forbidden unless data = RPXNow.user_data(params[:token])
 
    @user = User.find_by_identifier(data[:identifier]) #|| User.find_by_login(data[:login])
    if !@user
      @user = User.new(:login => data[:username],:identifier => data[:identifier])
      
      @user.save


    end
     session[:login] = @user.login
     session[:id] = @user.id
    redirect_to root_path
    notification = Notifier.find( :all, :conditions => {:user_id => session[:id]} )
    flash[:badge] = []
    notification.each {|f| flash[:badge] << f.badge_name}
    notification.each {|f| f.destroy}

    
end

def create
@session = Session.new(params[:session])
  if @session.valid?
    if Session.authenticate(params[:session][:login],params[:session][:password])
    session[:login] = @session.login
    flash[:message]='Connecté'
    redirect_to root_url
    else
    flash[:message]='Utilisateur et/ou mot de passe erronés'
    end

  else  
    render :action => 'new'  
  end 
end

def destroy
  session[:login] = nil
  session[:id] = nil
  redirect_to root_url
end

end
