class Word < ActiveRecord::Base
  has_many :answers
  has_many :results
  has_many :lessons, through: :results
  
  scope :some, ->{order("RAND()").limit Settings.lessons.words_per_lesson}
  scope :learned, ->(user){joins(:lessons).where lessons: {user_id: user.id}}
  scope :not_learned,
    ->(user){includes(:lessons)
      .where("lessons.user_id != ? OR lessons.user_id IS NULL",user.id)
      .references :lessons}
  
  belongs_to :category
  
  def correct_answer
    answers.find_by is_correct: true
  end
  
  def has_audio?
    !audio.nil?
  end
end
