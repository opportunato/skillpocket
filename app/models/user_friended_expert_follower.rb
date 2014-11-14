class UserFriendedExpertFollower < ActiveRecord::Base
  belongs_to :user
  belongs_to :expert, class_name: 'User'

  scope :without_info, ->  { where('user_friended_expert_followers.twitter_handle' => nil)}
  scope :with_info,    ->  { where.not('user_friended_expert_followers.twitter_handle' => nil)}
end