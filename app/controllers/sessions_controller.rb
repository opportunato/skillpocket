class SessionsController < ApplicationController
  before_filter :admin_login

  def new
    if @current_user.present?
      redirect_to profile_path
    end
  end

  def create
    if profile = create_profile
      session[:user_id] = profile.id
      redirect_to profile_path
    end
  end

private

  def auth_hash
    request.env['omniauth.auth']
  end

  def create_profile
    ProfileCreator.perform(token: auth_hash[:credentials][:token], secret: auth_hash[:credentials][:secret])
  end
end
