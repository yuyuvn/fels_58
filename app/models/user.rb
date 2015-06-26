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
  
  scope :higher_rank, ->(user){joins(:lessons).group(:user_id)
    .having "COUNT(lessons.id) > ?", user.lessons.count}
  
  def learned_words
    lessons.collect{|lesson| lesson.results.count}.sum
  end
  
  def follow other_user
    following_relationships.create followed_id: other_user.id
  end
  
  def unfollow other_user
    following_relationships.find_by(followed_id: other_user.id).destroy
  end
  
  def following? other_user
    following.include? other_user
  end
  
  def following_activities
    Activity.followed self
  end
  
  def rank
    User.higher_rank(self).length + 1
  end
end
