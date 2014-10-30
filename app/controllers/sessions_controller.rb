class SessionsController < ApplicationController
  skip_before_action :authenticate!, only: [:create]

  def create
    if user = create_user
      authenticate!

      if user.skill.present?
        redirect_to user_path("@#{user.twitter_handle}")
      elsif user.email.present?
        redirect_to onboarding_step_3_path
      else
        redirect_to onboarding_step_2_path
      end
    end
  end

  def destroy
    warden.logout
    redirect_to :root
  end

private

  def auth_hash
    request.env['omniauth.auth']
  end

  def create_user
    UserCreator.perform(
      token: auth_hash[:credentials][:token],
      secret: auth_hash[:credentials][:secret]
    )
  end
end
