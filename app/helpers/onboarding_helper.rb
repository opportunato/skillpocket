module OnboardingHelper
  def current_onboarding_step
    if current_user && current_user.expert?
      nil
    elsif current_user && current_user.email.present?
      3
    elsif current_user
      2
    else
      1
    end
  end
end
