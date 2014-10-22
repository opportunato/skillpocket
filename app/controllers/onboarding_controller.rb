class OnboardingController < ApplicationController
  skip_before_action :authenticate!, only: [:step1]

  before_action :set_user, only: [:step2, :step2_submit, :step3, :step3_submit]

  def step1
    check_for_current_step(1)
  end

  def step2
    check_for_current_step(2)
  end

  def step2_submit
    if @user.update(user_params)
      redirect_to onboarding_step3_path
    else
      render "step2"
    end
  end

  def step3
    check_for_current_step(3)
    @skill = @user.skill || Skill.new
  end

  def step3_submit
    @skill = @user.skill || Skill.new

    if SkillCreator.perform(@user, skill_params)
      redirect_to onboarding_success_path
    else
      render "step3"
    end
  end

  def succcess
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

  def user_current_step(user)
    if !user.present?
      1
    elsif !user.email.present?
      2
    elsif !user.skill.present?
      3
    else
      nil
    end
  end

  def check_for_current_step(step)
    if user_current_step(current_user) != step
      redirect_to root_path
    end
  end
end
