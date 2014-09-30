require 'rails_helper'

RSpec.describe 'GET /v1/categories' do
  it 'returns categories' do
    first_category = create :category_tag
    second_category = create :category_tag
    third_category = create :tag

    get "/api/v1/categories/"

    expect(response_json).to eq([
      {
        'id' => first_category.id,
        'name' => first_category.name
      }, 
      {
        'id' => second_category.id,
        'name' => second_category.name
      }
    ])
  end
end
