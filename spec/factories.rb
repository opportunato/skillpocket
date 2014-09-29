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
    SecureRandom.random_number(1000000)
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

    factory :expert do
      after(:create) do |user, evaluator|
        create(:skill, expert: user)
      end
    end
  end

  factory :tag do
    name
    is_category false
  end
end