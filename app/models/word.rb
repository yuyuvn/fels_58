class Word < ActiveRecord::Base
  has_many :answers, dependent: :destroy
  has_many :results, dependent: :destroy
  has_many :lessons, through: :results  
  belongs_to :category
  
  scope :some, ->{order("RAND()").limit Settings.lessons.words_per_lesson}
  scope :learned, ->user{joins(:lessons).where(lessons: {user_id: user.id})
    .where.not results: {answer_id: nil}}
  scope :not_learned,
    ->user{includes(:lessons).where("lessons.user_id != ? OR
      lessons.user_id IS NULL OR results.answer_id IS NULL",user.id)
      .references :lessons}
  scope :all_words, ->user{}
  
  accepts_nested_attributes_for :answers,
    reject_if: ->attributes{attributes["content"].blank?},
    allow_destroy: true
  
  validates :content, presence: true
  validates :answers, length: {minimum: Settings.word.minimum_answers}
  validate :correct_answer_number
  
  mount_uploader :audio, AudioUploader
  
  def correct_answer
    answers.find_by is_correct: true
  end
  
  private
  def correct_answer_number
    unless answers.reject(&:marked_for_destruction?)
      .select{|answer| answer.is_correct?}.length == 1
      self.errors.add :base, I18n.t("words.errors.wrong_correct_answer_number")
    end
  end
end
