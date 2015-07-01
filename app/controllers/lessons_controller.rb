class LessonsController < ApplicationController
  before_action :logged_in_user
  before_action :get_lesson, only: [:edit, :update]
  before_action :check_finished, only: [:edit, :update]
  
  def create
    category = Category.find params[:category_id]
    if @lesson = category.lessons.create(user: current_user)
      flash[:success] = t "messages.lessons.created"
      redirect_to edit_category_lesson_path category, @lesson
    else
      flash[:danger] = t "messages.lessons.errors.can_not_create_lesson"
      redirect_to categories_path
    end
  end
  
  def edit
  end
  
  def update
    if @lesson.update_attributes(lesson_params)
      flash[:success] = t "messages.lessons.finished"
      redirect_to lesson_results_path @lesson
    else
      render "edit"
    end
  end
  
  private
  def get_lesson
    @lesson = Lesson.find params[:id]
  end
  
  def check_finished
    redirect_to lesson_results_path @lesson if @lesson.finished?
  end
  
  def lesson_params
    params.require(:lesson).permit results_attributes: [:id, :answer_id]
  end
end
