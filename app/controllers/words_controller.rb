class WordsController < ApplicationController
  def index
    @category = Category.find params[:category_id]
    @filter_state = params[:filter_state] || Settings.category_type.all
    @words = @category.filter_words(current_user, @filter_state)
      .page params[:page]
    @categories_list = Category.all.collect{|category|
      [category.name, category_words_path(category)]}
    
    respond_to do |format|
      format.html
      format.js
    end
  end
end
