class UserCreator
  def initialize(token, secret)
    @token = token
    @secret = secret
  end

  def create
    user_data = TwitterTalker.new(@token, @secret).user

    # FIXME: find_or_create
    if User.exists?(twitter_id: user_data.id.to_s)
      User.find_by(twitter_id: user_data.id.to_s)
    else
      create_from_user_data(user_data)
    end
  end

  def self.perform(token: nil, secret: nil)
    # TODO: check if both are provided. fail otherwise
    self.new(token, secret).create
  end

private

  def create_from_user_data(user_data)
    user = User.new({
      full_name: user_data.name,
      about: user_data.description,
      twitter_id: user_data.id,
      twitter_handle: user_data.screen_name,
      twitter_token: @token,
      twitter_token_secret: @secret,
      twitter_url: "https://twitter.com/#{user_data.screen_name}"
    })

    begin
      access_token = SecureRandom.hex
    end while User.exists?(access_token: access_token)

    user.access_token = access_token

    user.remote_photo_url = user_data.profile_image_url(:original)
    user.remote_profile_banner_url = user_data.profile_banner_url

    user.save(validate: false)
    PreapprovedHandle.preapprove(user)
    user
  end
end
