FactoryGirl.define do
  factory :conversation do
    older factory: :user
    newer factory: :user
  end
end
