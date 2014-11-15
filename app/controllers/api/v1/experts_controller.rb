class Api::V1::ExpertsController < ApiController
  has_scope :with_any_category, as: :category

  def index
    @experts = apply_scopes(User.approved.experts.geocoded)
    @experts = @experts.near_user(current_user)
    @experts = @experts.by_rating(current_user)
  end

  def show
    @expert = User.includes(:skill).friendly.find(params[:id])
  end
end
