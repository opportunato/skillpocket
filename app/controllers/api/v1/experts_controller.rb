class Api::V1::ExpertsController < ApiController
  has_scope :with_category, as: :category

  def index
    @experts = apply_scopes(User.experts.by_followers)
  end

  def show
    @expert = User.includes(:skill).friendly.find(params[:id])
  end
end
