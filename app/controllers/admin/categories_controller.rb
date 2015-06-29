class Admin::CategoriesController < ApplicationController
  before_action :logged_in_admin
  before_action :set_category, only: [:show, :edit, :update]

  def index
    @categories = Category.page params[:page]
  end

  def show
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "messages.category.created"
      redirect_to [:admin, @category]
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "messages.category.updated"
      redirect_to [:admin, @category]
    else
      render "edit"
    end
  end

  def destroy
    Category.find(params[:id]).destroy
    flash[:success] = t "messages.category.deleted"
    redirect_to admin_categories_url
  end

  private
  def category_params
    params.require(:category).permit :name, :description
  end

  def set_category
    @category = Category.find params[:id]
  end
end
