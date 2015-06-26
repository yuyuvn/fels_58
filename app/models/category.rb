class Category < ActiveRecord::Base
  has_many :lessons
  has_many :words
  
  def filter_words user, filter
    if Settings.category_type.all == filter
      words
    else
      words.send filter, user
    end
  end
end
