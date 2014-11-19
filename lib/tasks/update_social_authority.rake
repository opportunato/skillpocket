namespace :social_authority do
  desc "Update social authority for all experts"
  task :update => :environment do
    followerwonk_talker = FollowerwonkTalker.new

    users = User.experts.from_twitter

    users_map = users.reduce({}) do |memo, user|
      memo[user.id] = user.twitter_handle

      memo
    end

    followerwonk_results = followerwonk_talker.for_users(users_map)

    update_values = followerwonk_results.map do |result|
      social_authority = User.sanitize(result[1].to_f)

      "(#{result[0]}, #{social_authority})"
    end

    ActiveRecord::Base.connection.execute <<-SQL
      update users
        set social_authority = new_values.social_authority
      from (values
        #{update_values.join(', ')}
      ) as new_values(id, social_authority) 
      where new_values.id = users.id
    SQL
  end
end