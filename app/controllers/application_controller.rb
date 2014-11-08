class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate!
  before_action :authenticate_admin_on_staging

  helper_method :signed_in?, :current_user

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

protected

  def authenticate!(options={})
    warden.authenticate!(scope: :user)
  end

  def authenticate_admin!(options={})
    warden.authenticate!(scope: :admin)
  end

  def authenticate_admin_on_staging
    if Rails.env.staging?
      authenticate_admin!
    end
  end

  def signed_in?
    !current_user.nil?
  end

  def admin_signed_in?
    !current_admin_user.nil?
  end

  def current_admin_user
    warden.user(:admin)
  end

  def current_user
    if warden.user(:admin)
      warden.user(:admin)
    else
      warden.user(:user)
    end
  end

  def is_admin?
    warden.user(:admin) && warden.user(:admin).role == "admin"
  end

private

  def warden
    env['warden']
  end
end
