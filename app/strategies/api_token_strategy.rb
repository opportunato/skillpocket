class ApiTokenStrategy < ::Warden::Strategies::Base
  def valid?
    request.env['omniauth.auth']
  end

  def authenticate!(options={})
    token = request.env['omniauth.auth'][:credentials][:token]
    user = User.find_by(twitter_token: token)
    user.nil? ? fail! : success!(user)
  end
end