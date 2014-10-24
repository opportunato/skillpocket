class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate!
  before_action :authenticate_admin!

  helper_method :signed_in?, :current_user

protected

  def authenticate!(options={})
    warden.authenticate(scope: :user)
  end

  def authenticate_admin!(options={})
    warden.authenticate(scope: :admin)
  end

  def signed_in?
    !current_user.nil?
  end

  def admin_signed_in?
    warden.authenticated?(:admin)
  end

  def current_user
    warden.user(:user)
  end

  def is_admin?
    warden.user(:admin) && warden.user(:admin).role == "admin"
  end

private

  def warden
    env['warden']
  end
end
