class Api::V1::ExpertsController < ApiController
  has_scope :with_any_category, as: :category

  def index
    @experts = apply_scopes(User.approved.experts.geocoded.where.not(id: current_user.id)).by_rating(current_user)
  end

  def show
    @expert = User.includes(:skill).friendly.include_is_followed(current_user).select('users.*').find(params[:id])
  end
end
