class WordsController < ApplicationController
  def index
    category = Category.find params[:category_id]
    @words = category.words.page params[:page]
    
    respond_to do |format|
      format.html
      format.js
    end
  end
end
