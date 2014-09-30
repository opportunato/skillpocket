FactoryGirl.define do
  factory :tag do
    name
    is_category false

    factory :category_tag do
      is_category true
    end
  end
end
