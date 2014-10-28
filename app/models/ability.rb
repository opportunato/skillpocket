class Ability
  include CanCan::Ability

  def initialize(user)      
    # Anyone
    # 
    can :read, User, approved: true
    can :manage, :onboard_step1

    return unless user

    # Admin
    # 
    if user.admin?
      can :manage, :all

    # User
    # 
    else
      cannot :manage, :onboard_step1
      can :manage, :onboard_step2 if !step2_passed?(user)
      can :manage, :onboard_step3 if step2_passed?(user) && !step3_passed?(user)
      can :read, :onboard_success if step3_passed?(user)

      can :read, User do |checking_user|
        user.id = checking_user.id && step3_passed?(user) && user.approved
      end
      can :update, User, approved: true, id: user.id
      can :update, Skill, id: user.id
    end
  end

private

  def step2_passed?(user)
    user.email.present?
  end

  def step3_passed?(user)
    user.skill.present?
  end
end
