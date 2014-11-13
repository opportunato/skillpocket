class Api::V1::ExpertsController < ApiController
  has_scope :with_category, as: :category

  def index
    @experts = apply_scopes(User.approved.experts.geocoded)
    @experts = @experts.near_user(current_user)
    @experts = @experts.order("users.created_at ASC")
  end

  def show
    @expert = User.includes(:skill).friendly.find(params[:id])
  end
end
