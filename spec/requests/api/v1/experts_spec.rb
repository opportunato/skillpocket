require 'rails_helper'

RSpec.describe Api::V1::ExpertsController do
  let(:user) { create :user }

  let!(:first_expert) { create :skilled_user }
  let!(:second_expert) { create :category_tag_skilled_user }
  let!(:unapproved_expert) { create :unapproved_expert }

  it 'returns expert in correct format'

  it 'returns experts in correct format' do
    login_as(user)
    get "/api/v1/experts/"

    # it_behaves_like 'token protected resource'

    expect(response_json).to eq([
      {
        'about' => first_expert.about,
        'behance_url' => first_expert.behance_url,
        'email' => first_expert.email,
        'github_url' => first_expert.github_url,
        'full_name' => first_expert.full_name,
        'id' => first_expert.id,
        'job' => first_expert.job,
        'linkedin_url' => first_expert.linkedin_url,
        'photo' => first_expert.photo.url(:small),
        'price' => first_expert.price,
        'authority' => first_expert.social_authority.to_i,
        'profile_banner_url' => first_expert.profile_banner.url(:normal),
        'skill_title' => first_expert.skill.title,
        'slug' => first_expert.slug,
        'stackoverflow_url' => first_expert.stackoverflow_url,
        'categories' => [],
        'tags' => [{
          'id' => first_expert.skill.tags.first.id,
          'name' => first_expert.skill.tags.first.name
        }],
        'twitter_url' => first_expert.twitter_url,
        'website_url' => first_expert.website_url
      },
      {
        'id' => second_expert.id,
        'email' => second_expert.email,
        'about' => second_expert.about,
        'behance_url' => second_expert.behance_url,
        'github_url' => second_expert.github_url,
        'full_name' => second_expert.full_name,
        'job' => second_expert.job,
        'linkedin_url' => second_expert.linkedin_url,
        'photo' => second_expert.photo.url(:small),
        'price' => second_expert.price,
        'authority' => second_expert.social_authority.to_i,
        'profile_banner_url' => second_expert.profile_banner.url(:normal),
        'skill_title' => second_expert.skill.title,
        'slug' => second_expert.slug,
        'stackoverflow_url' => second_expert.stackoverflow_url,
        'categories' => [{
          'id' => second_expert.skill.tags.last.id,
          'name' => second_expert.skill.tags.last.name
        }],
        'tags' => [{
          'id' => second_expert.skill.tags.first.id,
          'name' => second_expert.skill.tags.first.name
        }, {
          'id' => second_expert.skill.tags.last.id,
          'name' => second_expert.skill.tags.last.name
        }],
        'twitter_url' => second_expert.twitter_url,
        'website_url' => second_expert.website_url
      }
    ])
  end

  context "when sent the category" do
    it "returns only experts with that category" do
      login_as(user)
      get "/api/v1/experts?category=#{URI.encode(second_expert.skill.tags.last.name)}"

      expect(response_json.size).to eq 1
      expect(response_json.first['id']).to eq second_expert.id
    end
  end

  context 'when given a slug' do
    it 'returns expert' do
      login_as(user)
      get "/api/v1/experts/#{first_expert.slug}"

      expect(response_json['id']).to eq first_expert.id
    end
  end
end
