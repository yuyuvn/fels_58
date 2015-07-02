class Result < ActiveRecord::Base
  belongs_to :answer
  belongs_to :lesson
  belongs_to :word
  
  scope :unanswered, ->{where answer_id: nil}
  scope :answered, ->{where.not answer_id: nil}
  scope :correct, ->{joins(:answer).where "answers.is_correct = ?", true}
  
  def is_correct?
    answer.is_correct?
  end
end
