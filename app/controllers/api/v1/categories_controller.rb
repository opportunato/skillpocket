class Api::V1::CategoriesController < ApiController 
  def index
    @categories = Tag.categories
  end
end
