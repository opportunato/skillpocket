class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate!

  helper_method :signed_in?, :current_user

protected

  def authenticate!(options={})
    warden.authenticate!(options)
  end

  def authenticate_admin!(options={})
    warden.authenticate!(:password, scope: :admin)
  end

  def signed_in?
    !current_user.nil?
  end

  def admin_signed_in?
    warden.authenticated?(:sudo)
  end

  def current_user
    warden.user
  end

  def warden
    request.env['warden']
  end
end
