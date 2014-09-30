FactoryGirl.define do
  sequence(:description) { |n| "description #{n}" }
  sequence(:title) { |n| "title #{n}" }
  sequence(:price) { SecureRandom.random_number(100) }

  factory :skill do
    description
    title
    price
    expert factory: :user

    factory :tagged_skill do
      after(:create) do |skill|
        skill.tags << create(:tag)
      end
    end

    factory :category_tagged_skill do
      after(:create) do |skill|
        skill.tags << create(:tag)
        skill.tags << create(:category_tag)
      end
    end
  end
end
