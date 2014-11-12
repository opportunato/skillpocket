class TwitterFriendsSyncer
  def initialize(users)
    @users = users
  end

  def sync
    redis = Redis.new

    expert_twitter_ids = Redis::Set.new("experts")

    experts = User.experts.from_twitter

    expert_ids = experts.map(&:twitter_id)
    expert_twitter_ids_map = experts.reduce({}) { |memo, expert| memo[expert.twitter_id] = expert.id; memo; }

    expert_twitter_ids.clear
    expert_twitter_ids.merge(*expert_ids)

    @users.each do |user|
      update_twitter_friend_ids(user)

      user_friended_experts = user.twitter_friends & expert_twitter_ids
      user_friended_expert_objects = user_friended_experts.map do |expert_id|
        { 
          user_id: user.id,
          expert_id: expert_twitter_ids_map[expert_id]
        }
      end

      UserFriendedExpert.where(user: user).destroy_all
      UserFriendedExpert.create(user_friended_expert_objects)
    end
  end

private

  def update_twitter_friend_ids(user)
    twitter_talker = TwitterTalker.new(user.twitter_token, user.twitter_token_secret)

    friend_ids = twitter_talker.friend_ids(user_id: user.twitter_id)
    user.twitter_friends.clear

    if friend_ids.length > 0
      user.twitter_friends.merge(*friend_ids)
    end
  end
end