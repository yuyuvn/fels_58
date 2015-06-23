class Relationship < ActiveRecord::Base
  include LogModule

  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  
  validates :follower_id, presence: true
  validates :followed_id, presence: true

  after_create :create_follow_log
  after_destroy :create_unfollow_log
end
