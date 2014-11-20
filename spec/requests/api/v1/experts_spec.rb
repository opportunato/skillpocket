require 'rails_helper'

RSpec.describe Api::V1::ExpertsController do
  let!(:first_expert) { create :skilled_user }
  let!(:second_expert) { create :category_tag_skilled_user }
  let!(:unapproved_expert) { create :unapproved_expert }

  let(:user) { create :user_with_friended_experts, friended_experts: [second_expert] }

  it 'returns expert in correct format'

  it 'returns experts in correct format' do
    get "/api/v1/experts/", nil, as(user)

    # it_behaves_like 'token protected resource'

    expect(response_json.size).to eq 2
    expect(response_json.first).to eq({
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
        'handle' => second_expert.twitter_handle,
        'stackoverflow_url' => second_expert.stackoverflow_url,
        'categories' => [{
          'id' => second_expert.skill.tags.last.id,
          'name' => second_expert.skill.tags.last.name
        }],
        'distance' => 0.0,
        'tags' => [
          {
            'id' => second_expert.skill.tags.last.id,
            'name' => second_expert.skill.tags.last.name
          }, {
            'id' => second_expert.skill.tags.first.id,
            'name' => second_expert.skill.tags.first.name
        }],
        'twitter_url' => second_expert.twitter_url,
        'website_url' => second_expert.website_url,
        'is_followed' => true
      })

    expect(response_json.last).to eq({
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
        'handle' => first_expert.twitter_handle,
        'stackoverflow_url' => first_expert.stackoverflow_url,
        'categories' => [],
        'distance' => 0.0,
        'tags' => [{
          'id' => first_expert.skill.tags.first.id,
          'name' => first_expert.skill.tags.first.name
        }],
        'twitter_url' => first_expert.twitter_url,
        'website_url' => first_expert.website_url,
        'is_followed' => false
      })
  end

  context "when sent the category" do
    it "returns only experts with that category" do
      get "/api/v1/experts?category=#{URI.encode(second_expert.skill.tags.last.name)}", nil, as(user)

      expect(response_json.size).to eq 1
      expect(response_json.first['id']).to eq second_expert.id
    end
  end

  context "when sent the non category tag" do
    it "returns experts with that tag" do
      get "/api/v1/experts?category=#{URI.encode(first_expert.skill.tags.last.name)}", nil, as(user)

      expect(response_json.size).to eq 1
      expect(response_json.first['id']).to eq first_expert.id
    end
  end

  context 'when given a slug' do
    it 'returns expert' do
      get "/api/v1/experts/#{first_expert.slug}", nil, as(user)
      expect(response_json['id']).to eq first_expert.id
    end

    it 'for those not followed' do
      get "/api/v1/experts/#{first_expert.slug}", nil, as(user)
      expect(response_json['is_followed']).to eq false
    end

    it 'for those followed' do
      get "/api/v1/experts/#{second_expert.slug}", nil, as(user)
      expect(response_json['is_followed']).to eq true
    end
  end
end
