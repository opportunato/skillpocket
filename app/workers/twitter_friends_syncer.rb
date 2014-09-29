class TwitterFriendsSyncer
  include Sidekiq::Worker

  def perform(user_id=nil)
    users = user_id.present? ? [User.find(user_id)] : User.all
    redis = Redis.new

    experts = Redis::Set.new('experts')
    expert_ids = User.experts.pluck(:twitter_id).map { |id| id.to_i }
    experts.clear
    experts.merge(*expert_ids)

    users.each do |user|
      twitter_talker = TwitterTalker.new(user.twitter_token, user.twitter_token_secret)

      friend_ids = twitter_talker.friend_ids(user_id: user.twitter_id)
      user.twitter_friends.clear
      user.twitter_friends.merge(*friend_ids)

      user_friended_experts = user.twitter_friends & experts
      user_friended_expert_objects = user_friended_experts.map do |expert_id|
        { 
          user_id: user.id,
          expert_id: expert_id
        }
      end

      UserFriendedExpert.where(user: user).destroy_all
      UserFriendedExpert.create(user_friended_expert_objects)
    end
  end
end