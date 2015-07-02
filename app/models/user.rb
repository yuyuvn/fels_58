class User < ActiveRecord::Base
  include LogModule
  
  has_many :activities, as: :target
  has_many :activities, ->{newest}, dependent: :destroy
  has_many :lessons, dependent: :destroy
  has_many :results, ->{answered}, through: :lessons
  has_many :following_relationships, class_name: "Relationship",
    foreign_key: "follower_id", dependent: :delete_all
  has_many :followers_relationships, class_name: "Relationship",
    foreign_key: "followed_id", dependent: :delete_all
  has_many :following, through: :following_relationships, source: :followed
  has_many :followers, through: :followers_relationships, source: :follower
  
  has_secure_password
  
  validates :email,
    format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i},
    presence: true, length: {maximum: 255},
    uniqueness: {case_sensitive: false}
  validates :password, allow_blank: true,
    length: {minimum: Settings.user.password.minimum_characters}
  validates :name, presence: true, length: {maximum: 50}
  
  after_destroy :destroy_activities
  
  scope :higher_rank, ->user{joins(:results).group(:user_id)
    .having "COUNT(results.id) > (?)", user.results.select("COUNT(*)")}
  
  def learned_words
    results.count
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
    User.higher_rank(self).count.count + 1
  end
  
  def to_param
    [id, name.parameterize].join "-"
  end
end
