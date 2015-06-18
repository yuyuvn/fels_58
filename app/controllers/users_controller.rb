class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :edit, :update]
  before_action :correct_user, only: [:edit, :update]
  
  def edit
    @user = User.find params[:id]
  end
  
  def update
    @user = User.find params[:id]
    if @user.update_attributes user_params
      flash[:success] = I18n.t :profile_updated_message
      redirect_to root_url
    else
      render 'edit'
    end
  end
  
  def show
    @user = User.find params[:id]
  end
  
  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end
  
  def correct_user
    @user = User.find params[:id]
    redirect_to root_url unless current_user? @user
  end
end
