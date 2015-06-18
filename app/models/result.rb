class Result < ActiveRecord::Base
  belongs_to :answer
  belongs_to :lesson
  belongs_to :word
  
  def is_correct?
    answer.is_correct?
  end
end
