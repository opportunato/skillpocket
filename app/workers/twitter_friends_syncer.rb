class TwitterFriendsSyncer
  include Sidekiq::Worker

  def perform(user_id=nil)
    users = user_id.present? ? [User.find(user_id)] : User.all
    redis = Redis.new

    experts = User.experts
    expert_ids = experts.pluck(:twitter_id).map { |id| id.to_i }

    expert_info = Redis::Hash.new('expert_info')
    expert_info.clear
    experts.each do |expert|
      expert_info[expert.twitter_id] = expert.id
    end

    expert_twitter_ids = Redis::Set.new('expert_twitter_ids')
    expert_twitter_ids.clear
    expert_twitter_ids.merge(*expert_ids)

    experts.each do |expert|
      twitter_talker = TwitterTalker.new(expert.twitter_token, expert.twitter_token_secret)
    
      follower_ids = twitter_talker.follower_ids(user_id: expert.twitter_id)
      expert.twitter_followers.clear
      expert.twitter_followers.merge(*follower_ids)
    end

    users.each do |user|
      twitter_talker = TwitterTalker.new(user.twitter_token, user.twitter_token_secret)

      friend_ids = twitter_talker.friend_ids(user_id: user.twitter_id)
      user.twitter_friends.clear
      user.twitter_friends.merge(*friend_ids)

      user_friended_experts = user.twitter_friends & expert_twitter_ids
      user_friended_expert_objects = user_friended_experts.map do |twitter_id|
        expert_id = expert_info[twitter_id]

        {
          user_id: user.id,
          expert_id: expert_id
        }
      end

      UserFriendedExpert.where(user: user).destroy_all
      UserFriendedExpert.create(user_friended_expert_objects)

      user_friended_expert_follower_objects = []

      experts.each do |expert|
        user_friended_expert_followers = expert.twitter_followers & user.twitter_friends
        expert_id = expert.id

        user_friended_expert_follower_objects.concat(user_friended_expert_followers.map do |twitter_id|
            {
              user_id: user.id,
              expert_id: expert_id,
              twitter_id: twitter_id
            }
          end
        )
      end

      UserFriendedExpertFollower.where(user: user).destroy_all
      UserFriendedExpertFollower.create(user_friended_expert_follower_objects)
    end
  end
end