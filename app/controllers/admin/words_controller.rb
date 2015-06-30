class Admin::WordsController < ApplicationController
  before_action :logged_in_admin
  before_action :set_category
  before_action :set_word, only: [:show, :edit, :update]

  def new
    @word = @category.words.build
    Settings.word.minimum_answers.times{@word.answers.build}
  end

  def create
    @word = @category.words.new word_params
    if @word.save
      flash[:success] = t "messages.word.created"
      redirect_to admin_category_url @category
    else
      if @word.answers.length < Settings.word.minimum_answers
        (Settings.word.minimum_answers - @word.answers.length)
          .times{@word.answers.build}
      end
      render :new
    end
  end

  def edit
  end

  def update
    if @word.update_attributes word_params
      flash[:success] = t "messages.word.editted"
      redirect_to admin_category_url @category
    else
      render :edit
    end
  end

  def destroy
    Word.find(params[:id]).destroy
    flash[:success] = t "messages.word.deleted"
    redirect_to admin_category_url @category
  end

  private
  def word_params
    params.require(:word).permit :content, :audio,
      answers_attributes: [:id, :content, :is_correct, :_destroy]
  end

  def set_category
    @category = Category.find params[:category_id]
  end

  def set_word
    @word = Word.find params[:id]
  end
end
