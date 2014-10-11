class ExpertSorter
  def initialize(experts, user)
    @experts = experts
    @user = user
  end

  def sort
    @experts
      .includes(:user_friended_experts, :user_friended_expert_followers)
      .order("coalesce(user_friended_experts.id, -1) desc, users.created_at desc")
      .references(:user_friended_experts, :user_friended_expert_followers)
  end
end