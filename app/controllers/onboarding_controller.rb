class OnboardingController < ApplicationController
  skip_before_action :authenticate!, only: [:step1]

  before_action :set_user, except: [:step1]

  def step1
    authorize :manage, :onboard_step1
  end

  def step2
    authorize :manage, :onboard_step2
  end

  def step2_submit
    authorize :manage, :onboard_step2

    if @user.update(user_params)
      redirect_to onboarding_step3_path
    else
      render "step2"
    end
  end

  def step3
    authorize :manage, :onboard_step3

    @skill = @user.skill || Skill.new
  end

  def step3_submit
    authorize :manage, :onboard_step3

    if SkillCreator.perform(@user, skill_params)
      redirect_to onboarding_success_path
    else
      render "step3"
    end
  end

  def succcess
    authorize :manage, :onboard_success
  end

private

  def user_params
    params.require(:user).permit(
      :full_name, :email, :job, :about, :photo, :profile_banner,
      :website_url, :facebook_url, :github_url, :behance_url,
      :stackoverflow_url, :linkedin_url
    )
  end

  def skill_params
    params.require(:skill).permit(:title, :price, :tags_text, categories_list: [])
  end

  def set_user
    @user = current_user
  end
end
