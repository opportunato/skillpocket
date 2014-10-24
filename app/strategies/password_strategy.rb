class PasswordStrategy < ::Warden::Strategies::Base
  def valid?
    params['username'] || params['password']
  end

  def authenticate!(options={})
    if (admin = User.admin).present?
      passed = params['username'] == ENV['USERNAME'] && Digest::SHA1.hexdigest(params['password']) == ENV['PASSWORD_HASH'] 
      passed ? success!(admin) : fail!("Could not log in")
    else
      fail!
    end
  end
end