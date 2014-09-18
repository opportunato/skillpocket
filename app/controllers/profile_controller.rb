class ProfileController < ApplicationController
  before_filter :admin_login
  before_filter :get_profile

  def index
    if @current_user.nil?
      redirect_to login_path
    end
  end

  def edit
  end

  def update
    @profile.update(profile_params)

    redirect_to profile_path
  end

private

  def get_profile
    @profile = @current_user
  end

  def profile_params
    params.require(:user).permit(:first_name, :last_name, :email, :job, :about)
  end
end
