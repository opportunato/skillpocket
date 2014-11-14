namespace :followers do
  desc "Update existing followers"
  task :lookup => :environment do
    twitter_talker = TwitterTalker.new(ENV['TWITTER_TOKEN'], ENV['TWITTER_TOKEN_SECRET'])

    users = UserFriendedExpertFollower.select(:twitter_id).without_info.group('twitter_id').limit(100)

    while (users.length > 0)
      users_data = twitter_talker.users(users.pluck(:twitter_id))

      users_data.each do |user|
        UserFriendedExpertFollower.where(twitter_id: user.id).update_all({
          twitter_handle:    user.screen_name,
          full_name:         user.name,
          photo_url:         user.profile_image_url(:normal).to_s
        })
      end

      users = UserFriendedExpertFollower.select(:twitter_id).without_info.group('twitter_id').limit(100)
    end
  end
end