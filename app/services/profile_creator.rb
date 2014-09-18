class ProfileCreator
  def initialize(uid, token, secret)
    @uid = uid
    @token = token
    @secret = secret
  end

  def create
    if User.exists?(twitter_id: @uid)
      user =  User.find_by(twitter_id: @uid)
    else
      user_data = TwitterTalker.new(@token, @secret).user

      user = create_from_user_data(user_data)
    end

    return user
  end

  def self.perform(uid: nil, token: nil, secret: nil)
    self.new(uid, token, secret).create
  end

private

  def create_from_user_data(user_data)
    user = User.new({
      first_name: FullNameParser.new(user_data.name).first_name,
      last_name: FullNameParser.new(user_data.name).last_name,
      about: user_data.description,
      twitter_id: user_data.id,
      twitter_token: @token,
      twitter_token_secret: @secret,
      twitter_link: "https://twitter.com/#{user_data.screen_name}"
    })

    begin
      access_token = SecureRandom.hex
    end while User.exists?(access_token: access_token)

    user.access_token = access_token

    user.remote_photo_url = user_data.profile_image_url
    user.remote_profile_banner_url = user_data.profile_banner_url

    user.save
    user
  end
end