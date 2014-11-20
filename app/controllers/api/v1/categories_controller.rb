class Api::V1::CategoriesController < ApiController
  skip_before_action :authenticate_with_token, only: [:index]

  def index
    @categories = Tag.categories
  end
end
