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
  
  accepts_nested_attributes_for :answers,
    reject_if: ->(attributes){attributes["content"].blank?},
    allow_destroy: true
  
  validates :content, presence: true
  validates :answers, length: {minimum: Settings.word.minimum_answers}
  validate :correct_answer_number
  
  mount_uploader :audio, AudioUploader
  
  def correct_answer
    answers.find_by is_correct: true
  end
  
  def has_audio?
    !audio.nil?
  end
  
  private
  def correct_answer_number
    if answers.reject(&:marked_for_destruction?)
      .select{|answer| answer.is_correct?}.length != 1
      self.errors.add :base, I18n.t("words.errors.wrong_correct_answer_number")
    end
  end
end
