class ApplicationController < ActionController::Base

  require 'sanitize'
  before_filter :current_user

  def current_user
    if session[:login]
    @current_user_login = session[:login]
    end
  end

  def format_tags(input)
   Sanitize.clean(input, Sanitize::Config::RESTRICTED).strip.gsub(/ +/,'-')
  end

  
end
