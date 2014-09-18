class Api::V1::ExpertsController < ApiController
  has_scope :with_category, as: :category

  def index
    @experts = apply_scopes(User.all.joins(:skill)).order("users.created_at ASC")
  end

  def show
    @expert = User.includes(:skill).friendly.find(params[:id])
  end
end
