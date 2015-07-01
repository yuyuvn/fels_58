class SessionsController < ApplicationController
  def new
    redirect_to root_url if logged_in?
  end
  
  def create
    redirect_to root_url if logged_in?
    user = User.find_by email: params[:session][:email].downcase
    if user && (user.authenticate params[:session][:password])
      log_in user
      flash[:success] = t "messages.sessions.logged_in", username: user.name
      redirect_to root_url
    else
      flash.now[:danger] = t "messages.sessions.invalid_email_password"
      render "new"
    end
  end
  
  def destroy
    log_out if logged_in?
    flash[:danger] = t "messages.sessions.logged_out"
    redirect_to root_url
  end
end
