class HttpTokenStrategy < ::Warden::Strategies::Base
  def valid?
    token.present?
  end

  def authenticate!
    user = User.find_by(access_token: token)
    user.nil? ? fail! : success!(user)
  end

protected

  def token
    header && header.match(/^Token token=\"(.+)\"$/) && $~[1]
  end

  def header
    request.env["HTTP_AUTHORIZATION"]
  end
end
