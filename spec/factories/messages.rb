FactoryGirl.define do
  factory :message do
    sender factory: :user
    recipient factory: :user
    is_read true
    body { Faker::Lorem.sentence }
  end
end
