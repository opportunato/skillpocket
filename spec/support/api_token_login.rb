module ApiTokenLogin
  def as user
    { 'HTTP_AUTHORIZATION' =>
      ActionController::HttpAuthentication::Token.encode_credentials(user.access_token)
    }
  end
end

RSpec.configure do |config|
  config.include ApiTokenLogin
end
