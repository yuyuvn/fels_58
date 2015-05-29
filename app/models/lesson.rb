class Lesson < ActiveRecord::Base
  has_many :results
  belongs_to :user
  belongs_to :category		
end
