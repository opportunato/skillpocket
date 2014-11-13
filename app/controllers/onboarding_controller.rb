class OnboardingController < ApplicationController
  include OnboardingHelper

  skip_before_action :authenticate!, only: [:step1]

  before_action :set_user, except: [:step1]
  before_action :user_location, except: [:step1, :step2]

  before_action :check_step_1, only: [:step1]
  before_action :check_step_2, only: [:step2, :step2_submit]
  before_action :check_step_3, only: [:step3, :step3_submit]

  def step1
    authorize! :manage, :onboard_step1
  end

  def step2
    authorize! :manage, :onboard_step2
  end

  def step2_submit
    authorize! :manage, :onboard_step2

    if @user.update(user_params)
      redirect_to onboarding_step_3_path
    else
      render "step2"
    end
  end

  def step3
    authorize! :manage, :onboard_step3

    @skill = @user.skill || Skill.new
  end

  def step3_submit
    authorize! :manage, :onboard_step3

    @skill_creator = SkillCreator.new(@user)

    if @skill_creator.create(skill_params)
      redirect_to onboarding_success_path
    else
      @skill = @skill_creator.skill
      render "step3"
    end
  end

  def succcess
    authorize! :manage, :onboard_success
  end

private
  def check_step_1
    check_step 1
  end

  def check_step_2
    check_step 2
  end

  def check_step_3
    check_step 3
  end

  def check_step(current_step)
    if current_onboarding_step && current_onboarding_step != current_step
      redirect_to "/onboarding/step/#{current_onboarding_step}"
    end
  end

  def user_params
    params.require(:user).permit(
      :full_name, :email, :job, :about, :photo, :profile_banner, 
      :profile_banner_cache,
      :website_url, :facebook_url, :github_url, :behance_url,
      :stackoverflow_url, :linkedin_url
    )
  end

  def skill_params
    params.require(:skill).permit(:title, :price, :tags_text, :smartphone_os, categories_list: [])
  end

  def set_user
    @user = current_user
  end

  def user_location
    current_user.update_location request.location, request.ip
  end
end
