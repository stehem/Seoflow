# encoding: UTF-8
class SessionsController < ApplicationController

def new
@session = Session.new
end



def create  
  if !params[:local]
    auth = request.env["omniauth.auth"]  
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)  
  else
    user = Session.authenticate(params[:session][:name], params[:session][:password])
  end

  if user
    session[:login], session[:id] = user.name, user.id
    redirect_to root_path
  else
    redirect_to new_session_path
    flash[:message] = "Identifiant et/ou mot de passe erroné."
  end

  notification = Notifier.find( :all, :conditions => {:user_id => session[:id]} )
  flash[:badge] = []
  notification.each {|f| flash[:badge] << f.badge_name}
  notification.each {|f| f.destroy}
end  

def destroy
  session[:login] = nil
  session[:id] = nil
  redirect_to root_url
end

end
