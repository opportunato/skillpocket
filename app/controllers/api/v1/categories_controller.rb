class Api::V1::CategoriesController < ApiController
  skip_before_action :authenticate!, only: [:index]

  def index
    @categories = Tag.categories
  end
end
