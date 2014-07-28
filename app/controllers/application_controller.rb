class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

protected

  def authenticate
    if Rails.env.production?
      authenticate_or_request_with_http_basic do |u, p| 
        u == ENV['USERNAME'] && Digest::SHA1.hexdigest(p) == ENV['PASSWORD_HASH']
      end
    end
  end
end
