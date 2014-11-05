class Api::V1::ExpertsController < ApiController
  has_scope :with_category, as: :category

  def index
    @experts = apply_scopes(User.experts)
    @experts = @experts.geocoded.near_user(current_user) if current_user.location_defined?
    @experts = @experts.order("users.created_at ASC")
  end

  def show
    @expert = User.includes(:skill).friendly.find(params[:id])
  end
end
