FactoryGirl.define do
  sequence(:title) { |n| "title #{n}" }
  sequence(:price) { SecureRandom.random_number(100) }

  factory :skill do
    title
    price
    expert factory: :user
    smartphone_os 'iOS'

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
