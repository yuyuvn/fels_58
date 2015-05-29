class Result < ActiveRecord::Base
  belongs_to :answer
  belongs_to :lesson
  belongs_to :word  
end
