class PasswordStrategy < ::Warden::Strategies::Base
  def valid?
    params['username'] || params['password']
  end

  def authenticate!
    passed = params['username'] == ENV['USERNAME'] && Digest::SHA1.hexdigest(params['password']) == ENV['PASSWORD_HASH'] && User.admin.present?
    passed ? success!(User.admin) : fail!("Could not log in")
  end
end