class TwitterTalker
  def initialize(token, secret)
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_KEY"]
      config.consumer_secret     = ENV["TWITTER_SECRET"]
      config.access_token        = token
      config.access_token_secret = secret
    end
  end

  def user
    @client.user
  end

  def friend_ids(options={})
    @client.friend_ids(options).to_a
  end

  def follower_ids(options={})
    @client.follower_ids(options).to_a
  end
end