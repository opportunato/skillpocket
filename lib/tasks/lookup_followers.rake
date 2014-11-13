namespace :followers do
  desc "Update existing followers"
  task :lookup => :environment do
    twitter_talker = TwitterTalker.new(ENV['TWITTER_TOKEN'], ENV['TWITTER_TOKEN_SECRET'])

    users = UserFriendedExpertFollower.select(:twitter_id).without_info.group('twitter_id').limit(100)

    while (users.length > 0)
      users_data = twitter_talker.users(users.pluck(:twitter_id))

      users_data.each do |user|
        user_data = twitter_talker.user

        UserFriendedExpertFollower.where(twitter_id: user_data.id).update_all({
          twitter_handle:    user_data.screen_name,
          full_name:         user_data.name,
          photo_url:         user_data.profile_image_url     
        })
      end

      users = UserFriendedExpertFollower.select(:twitter_id).without_info.group('twitter_id').limit(100)
    end
  end
end