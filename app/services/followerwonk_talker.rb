class FollowerwonkTalker
  def initialize
  end

  def for_user(username)
    @client.users = [username]
    @client.get_data

    @client.data[0][:social_authority]
  end

  def for_users(users_map)
    users = users_map.to_a
    user_groups = users.each_slice(25).to_a

    user_groups.reduce([]) do |memo, user_group|
      result = get_data_for_group(user_group)

      result.each do |user_info|
        memo.push([user_info[0], user_info[1]])
      end

      memo
    end
  end

private
  

  def get_data_for_group(user_group)
    client = SocialAuthority::Request.new access_id: ENV['FOLLOWERWONK_ID'], secret_key: ENV['FOLLOWERWONK_SECRET']

    client.users = user_group.map { |user| user[1] }
    client.get_data

    data = client.data

    begin
      user_group.map do |user|
        followerwonk_social_authority = data.select { |user_info| user_info[:screen_name] == user[1] }

        social_authority = if followerwonk_social_authority.length > 0
          followerwonk_social_authority[0][:social_authority]
        else
          0
        end

        [user[0], social_authority]
      end
    rescue NoMethodError
      puts "There have been errors while trying to run the script, please check."
    end
  end
end