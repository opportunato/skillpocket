FactoryGirl.define do
  sequence(:full_name) { |n| "name surname #{n}" }
  sequence(:name) { |n| "name #{n}" }
  sequence(:job) { |n| "job #{n}" }
  sequence(:about) { |n| "about #{n}" }
  sequence(:email) { |n| "something#{n}@something.org" }
  sequence(:access_token) { SecureRandom.hex(16) }
  sequence(:photo) { File.open Rails.root.join("db/fixtures/images/lera.png") }

  factory :user do
    about
    email
    photo
    full_name
    job
    access_token

    # TODO: these should differ
    behance_url "http://behance.com/"
    github_url "http://github.com/"
    linkedin_url "http://linkedin.com/"
    stackoverflow_url "http://stackoverflow.com/"
    twitter_url "http://twitter.com/"
    website_url "http://some-site.com/"

    factory :skilled_user do
      skill factory: :tagged_skill
    end

    factory :category_tag_skilled_user do
      skill factory: :category_tagged_skill
    end
  end
end
