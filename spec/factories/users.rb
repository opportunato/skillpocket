FactoryGirl.define do
  sequence(:full_name) { |n| "name surname #{n}" }
  sequence(:name) { |n| "name #{n}" }
  sequence(:job) { |n| "job #{n}" }
  sequence(:about) { |n| "about #{n}" }
  sequence(:email) { |n| "something#{n}@something.org" }
  sequence(:access_token) { SecureRandom.hex(16) }
  sequence(:photo) { File.open Rails.root.join("db/fixtures/images/lera.png") }
  sequence(:profile_banner) { File.open Rails.root.join("db/fixtures/images/lera.png") }
  sequence(:twitter_id) { |n| n.to_s }
  sequence(:twitter_token) { SecureRandom.hex(10) }
  sequence(:twitter_token_secret) { SecureRandom.hex(20) }

  factory :user do
    about
    email
    photo
    profile_banner
    full_name
    job
    access_token
    twitter_id
    twitter_token
    twitter_token_secret

    # TODO: these should differ
    behance_url "http://behance.com/"
    github_url "http://github.com/"
    linkedin_url "http://linkedin.com/"
    stackoverflow_url "http://stackoverflow.com/"
    twitter_url "http://twitter.com/"
    website_url "http://some-site.com/"

    latitude 30
    longitude 60

    trait :has_friended_experts do
      transient do
        friended_experts []
      end

      after(:create) do |user, evaluator|
        evaluator.friended_experts.each do |expert|
          create(:user_friended_expert, user: user, expert: expert)
        end
      end
    end

    factory :user_with_friended_experts do
      has_friended_experts
    end

    factory :expert do
      approved true
      social_authority { rand(0..100) }

      factory :skilled_user do
        after(:create) do |user, evaluator|
          create :tagged_skill, expert: user
        end
      end

      factory :unapproved_expert do
        approved false
      end

      factory :category_tag_skilled_user do
        after(:create) do |user, evaluator|
          create :category_tagged_skill, expert: user
        end
      end
    end

    factory :user_with_ios_device_token do
      ios_device_token { SecureRandom.hex }
    end
  end

  factory :user_friended_expert do
  end
end
