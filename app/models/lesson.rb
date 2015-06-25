class Lesson < ActiveRecord::Base
  include LogModule
  
  has_many :results
  belongs_to :user
  belongs_to :category
  
  accepts_nested_attributes_for :results
  
  after_initialize {self.correct_number ||= 0}
  after_create :add_results
  before_save :update_correct_number
  after_save :create_learned_log,
    if: ->(lesson){lesson.finished?}
    
  def finished?
    results.unanswered.count == 0
  end
  
  private
  def add_results
    category.words.some.each do |word|
      results.create word: word
    end
  end
  
  def update_correct_number
    self.correct_number = results.select{|result| result.is_correct?}.count
  end
end
