# @restful_api 1.0
#
# Experts
#
class Api::V1::ExpertsController < ApiController
  skip_before_action :authenticate!, only: [:index, :show]


  has_scope :with_category, as: :category

  # @url /experts
  # @action GET
  #
  # Shows all the nearest experts for the current request
  #
  # @optional [String] category Expert category
  #
  # @response [Array<Expert>] The requested book
  #
  def index
    @experts = apply_scopes(User.all.joins(:skill)).order("users.created_at ASC")
  end

  def show
    @expert = User.includes(:skill).friendly.find(params[:id])
  end
end
