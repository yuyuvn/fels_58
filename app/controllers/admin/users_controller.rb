class Admin::UsersController < ApplicationController
  before_action :logged_in_admin

  def index
    @users = User.page params[:page]
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new user_params
    if @user.save
      flash[:info] = t "messages.user.created"
      redirect_to @user
    else
      render "new"
    end
  end
  
  def edit
    @user = User.find params[:id]
  end
  
  def update
    @user = User.find params[:id]
    if @user.update_attributes user_params
      flash[:success] = t "messages.user.updated"
      redirect_to @user
    else
      render "edit"
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = t "messages.user.deleted"
    redirect_to admin_users_url
  end
  
  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end
end
