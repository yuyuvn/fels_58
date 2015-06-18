class Word < ActiveRecord::Base
  has_many :answers
  has_many :results
  
  belongs_to :category
  
  def correct_answer
    answers.find_by is_correct: true
  end
  
  def has_audio?
    !audio.nil?
  end
end
