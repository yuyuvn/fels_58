class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  include JavascriptHelper
  
  def logged_in_user
    unless logged_in?
      flash[:danger] = t "messages.request_login"
      redirect_to login_url
    end
  end
  
  def logged_in_admin
    unless logged_in_admin?
      flash[:danger] = t "messages.request_admin"
      redirect_to root_path
    end
  end
end
