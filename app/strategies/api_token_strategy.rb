class ApiTokenStrategy < ::Warden::Strategies::Base
  def valid?
    params['oauth_token']
  end

  def authenticate!
    token = request.params['oauth_token']
    user = User.find_by(twitter_token: twitter_token)
    user.nil? ? fail! : success!(user)
  end
end