class TwitterFriendsSyncer
  def initialize(users)
    @users = users
  end

  def sync
    redis = Redis.new

    expert_twitter_ids = Redis::Set.new("experts")

    experts = User.experts.approved.from_twitter

    expert_ids = experts.map(&:twitter_id)
    expert_twitter_ids_map = experts.reduce({}) { |memo, expert| memo[expert.twitter_id] = expert.id; memo; }

    expert_twitter_ids.clear
    expert_twitter_ids.merge(*expert_ids)

    
    experts.each do |expert|
      begin
        twitter_talker = TwitterTalker.new(expert.twitter_token, expert.twitter_token_secret)
      
        if twitter_talker.user.followers_count <= 75000
          follower_ids = twitter_talker.follower_ids(user_id: expert.twitter_id)
          expert.twitter_followers.clear
          if follower_ids.length > 0
            expert.twitter_followers.merge(*follower_ids)
          end
        else
          puts "User '#{expert.twitter_handle}' has too many followers."
        end
      rescue Twitter::Error::Unauthorized
        puts "User '#{expert.twitter_handle}' is unauthorized."
      rescue Twitter::Error::TooManyRequests
        puts "User '#{expert.twitter_handle}' exceeded request limit."
      rescue Twitter::Error
        puts "Unexplained Error on user #{expert.twitter_handle}'"
      end
    end

    @users.each do |user|
      begin
        user_id = User.sanitize(user.id)

        update_twitter_friend_ids(user)
        user_friended_experts = user.twitter_friends & expert_twitter_ids
        user_friended_expert_inserts = user_friended_experts.map do |expert_id|
          expert_id = User.sanitize(expert_twitter_ids_map[expert_id])

          "(#{user_id}, #{expert_id})"
        end

        ActiveRecord::Base.transaction do
          ActiveRecord::Base.connection.execute("DELETE FROM user_friended_experts WHERE user_id = #{user_id};")
          if user_friended_expert_inserts.length > 0
            ActiveRecord::Base.connection.execute("INSERT INTO user_friended_experts (user_id, expert_id) VALUES #{user_friended_expert_inserts.join(', ')};")
          end
        end

        user_friended_expert_follower_inserts = []

        experts.each do |expert|
          if user.id != expert.id
            user_friended_expert_followers = expert.twitter_followers & user.twitter_friends
            expert_id = expert.id

            user_friended_expert_follower_inserts.concat(user_friended_expert_followers.map do |twitter_id|
                expert_id = User.sanitize(expert_id)
                twitter_id = User.sanitize(twitter_id)

                "(#{user_id}, #{expert_id}, #{twitter_id})"
              end
            )
          end
        end

        ActiveRecord::Base.transaction do
          ActiveRecord::Base.connection.execute("DELETE FROM user_friended_expert_followers WHERE user_id = #{user_id}")
          if user_friended_expert_follower_inserts.length > 0
            ActiveRecord::Base.connection.execute("INSERT INTO user_friended_expert_followers (user_id, expert_id, twitter_id) VALUES #{user_friended_expert_follower_inserts.join(', ')};")
          end
        end
      rescue Twitter::Error::Unauthorized
        puts "User '#{user.twitter_handle}' is unauthorized."
      rescue Twitter::Error::TooManyRequests
        puts "User '#{user.twitter_handle}' exceeded request limit."
      rescue Twitter::Error
        puts "Unexplained Error on user #{user.twitter_handle}'"
      end
    end
  end

private

  def update_twitter_friend_ids(user)
    twitter_talker = TwitterTalker.new(user.twitter_token, user.twitter_token_secret)
    
    if twitter_talker.user.friends_count <= 75000
      friend_ids = twitter_talker.friend_ids(user_id: user.twitter_id)
      user.twitter_friends.clear

      if friend_ids.length > 0
        user.twitter_friends.merge(*friend_ids)
      end
    else
      puts "User '#{user.twitter_handle}' has too many friends."
    end
  end
end