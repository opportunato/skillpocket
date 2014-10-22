class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_admin
  before_action :authenticate!

  helper_method :signed_in?, :current_user

  def authenticate!(options={})
    warden.authenticate!(options)
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user
    warden.user
  end

  def warden
    request.env['warden']
  end

protected
  def authenticate_admin
    if Rails.env.production?
      authenticate_or_request_with_http_basic do |u, p| 
        u == ENV['USERNAME'] && Digest::SHA1.hexdigest(p) == ENV['PASSWORD_HASH']
      end
    end
  end
end
