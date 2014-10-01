FactoryGirl.define do
  sequence(:first_name) { |n| "first_name #{n}" }
  sequence(:last_name) { |n| "last_name #{n}" }
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
    first_name
    last_name
    job
    access_token

    # TODO: these should differ
    behance_link "http://behance.com/"
    github_link "http://github.com/"
    linkedin_link "http://linkedin.com/"
    stackoverflow_link "http://stackoverflow.com/"
    twitter_link "http://twitter.com/"
    website_link "http://some-site.com/"

    factory :skilled_user do
      skill factory: :tagged_skill
    end

    factory :category_tag_skilled_user do
      skill factory: :category_tagged_skill
    end
  end
end
