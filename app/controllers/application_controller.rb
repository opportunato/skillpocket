class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :set_current_user

protected

  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  def admin_login
    if Rails.env.production?
      authenticate_or_request_with_http_basic do |u, p| 
        u == ENV['USERNAME'] && Digest::SHA1.hexdigest(p) == ENV['PASSWORD_HASH']
      end
    end
  end

  def absolute_attachment_url(attachment_name, attachment_style = :original)
    "#{request.protocol}#{request.host_with_port}#{attachment_name.url(attachment_style)}"
  end
end
