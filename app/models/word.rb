class Word < ActiveRecord::Base
  has_many :answers
  has_many :results
  
  belongs_to :category
end
