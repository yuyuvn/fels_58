class Lesson < ActiveRecord::Base
  include LogModule
  
  has_many :results, dependent: :destroy
  has_many :activities, as: :target
  has_many :words, through: :results
  belongs_to :user
  belongs_to :category
  
  accepts_nested_attributes_for :results
  
  after_initialize ->{self.correct_number ||= 0}
  before_create ->{self.words = category.words.not_learned(user).some}
  before_save :update_correct_number
  after_save :create_learned_log, if: ->lesson{lesson.finished?}
  after_destroy :destroy_activities
  
  validate :check_words, on: :create
  
  scope :unfinished, ->{joins(:results).where results: {answer_id: nil}}
    
  def finished?
    !results.unanswered.any?
  end
  
  private  
  def update_correct_number
    self.correct_number = results.select{|result| result.is_correct?}.count
  end
  
  def check_words
    unless category.words.not_learned(user).any?
      self.errors.add :base, I18n.t("lessons.errors.no_word_available")
    end
  end
end
