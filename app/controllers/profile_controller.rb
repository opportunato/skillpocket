class ProfileController < ApplicationController
  before_action :set_user, only: [:index, :edit, :update]
  before_action :check_if_approved

  def index
  end

  def edit
  end

  def update
    if @user.update(user_params.except(:skill_attributes)) && SkillCreator.perform(@user, user_params[:skill_attributes])
      redirect_to profile_path
    else
      render "edit"
    end
  end

private
  # TODO eradicate duplication, repetition, all the horror here

  def user_params
    params.require(:user).permit(
      :full_name, :email, :job, :about, :photo, :profile_banner,
      :website_url, :facebook_url, :github_url, :behance_url,
      :stackoverflow_url, :linkedin_url,
      skill_attributes: [:title, :price, :tags_text, categories_list: []]
    )
  end

  def set_user
    @user = current_user
  end

  def check_if_approved
    user = current_user
    passed = signed_in? && user.email.present? && user.skill.present? && user.approved
  
    if !passed
      redirect_to :root
    end
  end
end
