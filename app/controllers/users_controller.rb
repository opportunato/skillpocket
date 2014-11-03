class UsersController < ApplicationController
  skip_before_action :authenticate!, only: [:show]
  before_action :set_user

  def show
    authorize! :read, @user
  end

  def edit
    authorize! :update, @user
  end

  def update
    authorize! :update, @user

    if @user.update(user_params.except(:skill_attributes)) && SkillCreator.new(@user).create(user_params[:skill_attributes])
      redirect_to user_path("@#{@user.twitter_handle}")
    else
      render "edit"
    end
  end

private

  def user_params
    params.require(:user).permit(
      :full_name, :email, :job, :about, :photo, :profile_banner, :profile_banner_cache,
      :website_url, :facebook_url, :github_url, :behance_url,
      :stackoverflow_url, :linkedin_url,
      skill_attributes: [:title, :price, :tags_text, categories_list: []]
    )
  end

  def set_user
    handle = params[:id].match /@([\w-]+)/

    @user = User.approved.find_by_handle(handle[1])
  end
end