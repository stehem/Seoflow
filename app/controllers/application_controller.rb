class ApplicationController < ActionController::Base

  require 'sanitize'
  before_filter :current_user, :check_uri

  def current_user
    if session[:login]
    @current_user_login = session[:login]
    end
  end

  def format_tags(input)
   Sanitize.clean(input).strip.gsub(/ +/,'-')
  end

  def check_uri
    redirect_to(request.protocol + "www." + request.host_with_port + request.request_uri , :status => :moved_permanently) if !/^www/.match(request.host)
  end
  
end
