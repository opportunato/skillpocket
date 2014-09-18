require 'rails_helper'

RSpec.describe 'GET /v1/categories' do
  it 'returns categories' do
    first_category = create(:tag, is_category: true)
    second_category = create(:tag, is_category: true)
    third_category = create(:tag, is_category: false)

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