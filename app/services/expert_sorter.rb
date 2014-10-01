class ExpertSorter
  def initialize(experts, user)
    @experts = experts
    @user = user
  end

  def sort
    @friended_experts = @experts
      .includes(:user_friended_experts)
      .where("user_friended_experts.id is not null")
      .references(:user_friended_experts)
      .order("users.created_at desc")

    @other_experts = @experts
      .includes(:user_friended_experts)
      .where("user_friended_experts.id is null")
      .references(:user_friended_experts)
      .order("users.created_at desc")

    @friended_experts + @other_experts
  end
end