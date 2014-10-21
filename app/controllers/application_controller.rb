class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
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
end
