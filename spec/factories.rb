FactoryGirl.define do
  sequence :first_name do |n|
    "first_name #{n}"
  end

  sequence :last_name do |n|
    "last_name #{n}"
  end

  sequence :name do |n|
    "name #{n}"
  end

  sequence :job do |n|
    "job #{n}"
  end

  sequence :about do |n|
    "about #{n}"
  end

  sequence :description do |n|
    "description #{n}"
  end

  sequence :email do |n|
    "something#{n}@something.org"
  end

  sequence :color do
    SecureRandom.hex(3)
  end

  sequence :secure_token do
    SecureRandom.hex(16)
  end

  sequence :title do |n|
    "title #{n}"
  end

  sequence :twitter_id do
    SecureRandom.random_number(1000000).to_s
  end

  sequence :twitter_token do
    SecureRandom.hex(16)
  end

  sequence :twitter_token_secret do
    SecureRandom.hex(20)
  end

  sequence :price do |n|
    SecureRandom.random_number(100)
  end

  sequence :photo do
    File.open Rails.root.join("db/fixtures/images/lera.png")
  end

  factory :skill do
    description
    price
    title
  end

  factory :user do
    about
    email
    photo
    first_name 
    last_name
    job

    behance_link "http://behance.com/"
    github_link "http://github.com/"
    linkedin_link "http://linkedin.com/"
    stackoverflow_link "http://stackoverflow.com/"
    twitter_link "http://twitter.com/"
    website_link "http://some-site.com/"

    twitter_id
    twitter_token
    twitter_token_secret

    trait :is_expert do
      after(:create) do |user, evaluator|
        create(:skill, expert: user)
      end      
    end

    trait :has_friended_experts do
      ignore do
        friended_experts []
      end

      after(:create) do |user, evaluator|
        evaluator.friended_experts.each do |expert|
          create(:user_friended_expert, user: user, expert: expert)
        end
      end
    end

    trait :has_friended_expert_followers do
      ignore do
        friended_experts []
        friended_expert_followers_number 0
      end

      after(:create) do |user, evaluator|
        evaluator.friended_experts.each do |expert|
          create(:user_friended_expert_follower, user: user, expert: expert)
        end
      end
    end

    factory :expert do
      is_expert
    end

    factory :user_with_friended_experts do
      has_friended_experts
    end

    factory :user_with_friended_expert_followers do
      has_friended_experts
    end

    factory :user_with_friended_experts_and_followers do
      has_friended_experts
      has_friended_expert_followers
    end
  end

  factory :user_friended_expert do
  end

  factory :user_friended_expert_follower do
    twitter_id
  end

  factory :tag do
    name
    is_category false
  end
end