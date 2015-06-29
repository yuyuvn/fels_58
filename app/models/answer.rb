class Answer < ActiveRecord::Base
  has_many :results
  belongs_to :word
  
  validates :content, presence: true
  validates_uniqueness_of :content, scope: :word
end
