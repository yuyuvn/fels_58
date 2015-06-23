module LogModule
  private
  def create_follow_log
    Activity.create user_id: follower_id,
      target_id: followed_id,
      state: Settings.activity_state.follow
  end
  
  def create_unfollow_log
    Activity.create user_id: follower_id,
      target_id: followed_id,
      state: Settings.activity_state.unfollow
  end
  
  def create_learned_log
    Activity.create user_id: user_id,
      target_id: category_id,
      state: Settings.activity_state.learned
  end
end