class User < ActiveRecord::Base
  has_many :activities, ->{newest}
  has_many :lessons
  has_many :following_relationships, class_name: "Relationship",
    foreign_key: "follower_id", dependent: :destroy
  has_many :followers_relationships, class_name: "Relationship",
    foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :following_relationships, source: :followed
  has_many :followers, through: :followers_relationships, source: :follower
  
  has_secure_password
  
  def learned_words
    lessons.sum :correct_number
  end
  
  def follow other_user
    following_relationships.create followed_id: other_user.id
    activities.create target_id: other_user.id,
      state: Settings.activity_state.follow
  end
  
  def unfollow other_user
    following_relationships.find_by(followed_id: other_user.id).destroy
    activities.create target_id: other_user.id,
      state: Settings.activity_state.unfollow
  end
  
  def following? other_user
    following.include? other_user
  end
end
