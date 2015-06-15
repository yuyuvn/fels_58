class SessionsController < ApplicationController
  def new
    redirect_to root_url if logged_in?
  end
  
  def create
    redirect_to root_url if logged_in?
    user = User.find_by email: params[:session][:email].downcase
    if user && (user.authenticate params[:session][:password])
      log_in user
      redirect_to root_url
    else
      flash.now[:danger] = I18n.t "invalid_email_password_combination"
      render 'new'
    end
  end
  
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
