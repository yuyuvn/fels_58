class UsersController < ApplicationController
  before_action :set_user
  before_action :logged_in_user, only: [:show, :edit, :update]
  before_action :correct_user, only: [:edit, :update]
    
  def show
  end
  
  def edit
  end
  
  def update
    if @user.update_attributes user_params
      flash[:success] = t "messages.user.updated"
      redirect_to root_url
    else
      render "edit"
    end
  end
  
  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end
  
  def correct_user
    redirect_to root_url unless current_user? @user
  end
  
  def set_user
    @user = User.find params[:id]
  end
end
