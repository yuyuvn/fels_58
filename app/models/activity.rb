class Activity < ActiveRecord::Base  
  belongs_to :user
  belongs_to :target, :polymorphic => true
  
  scope :newest, ->{order created_at: :desc}
  scope :followed, ->user{where("user_id IN (?) OR user_id = ?",
    user.following.select("user_id"), user.id).order created_at: :desc}
  
  Settings.activity_state.each do |state_key, state_value|
    define_method ("is_#{state_key}?") {state == state_value}
  end
end
