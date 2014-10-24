class ProfileController < ApplicationController
  before_action :set_user, only: [:index, :edit, :update]

  def index
    check_for_current_step("done")
  end

  def edit
    check_for_current_step("done")
  end

  def update
    check_for_current_step("done")

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

  def user_current_step(user)
    if !signed_in?
      1
    elsif !user.email.present?
      2
    elsif !user.skill.present?
      3
    else
      "done" # TODO extremely bad code style, need to rewrite pretty much everything
    end
  end

  def check_for_current_step(implied_step)
    binding.remote_pry
    if user_current_step(current_user) != implied_step
      redirect_to root_path
    end
  end
end
