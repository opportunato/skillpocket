class AdminController < ApplicationController
  skip_before_action :authenticate!
  before_action :authenticate_admin

protected
  def authenticate_admin
    if Rails.env.production?
      authenticate_or_request_with_http_basic do |u, p| 
        u == ENV['USERNAME'] && Digest::SHA1.hexdigest(p) == ENV['PASSWORD_HASH']
      end
    end
  end
end