require 'rails_helper'

RSpec.describe Api::V1::ExpertsController do
  let!(:first_expert) { create :skilled_user }
  let!(:second_expert) { create :category_tag_skilled_user }

  it 'returns experts' do
    get "/api/v1/experts/"

    expect(response_json).to eq([
      {
        'about' => first_expert.about,
        'behance_link' => first_expert.behance_link,
        # 'color' => first_expert.skill.color,
        'email' => first_expert.email,
        'github_link' => first_expert.github_link,
        'first_name' => first_expert.first_name,
        'full_name' => first_expert.full_name,
        'id' => first_expert.id,
        'job' => first_expert.job,
        'last_name' => first_expert.last_name,
        'linkedin_link' => first_expert.linkedin_link,
        'photo' => first_expert.photo.url(:small),
        'price' => first_expert.price,
        'profile_banner_url' => first_expert.profile_banner.url(:normal),
        'skill_title' => first_expert.skill.title,
        'skill_description' => first_expert.skill.description,
        'slug' => first_expert.slug,
        'stackoverflow_link' => first_expert.stackoverflow_link,
        'categories' => [],
        'tags' => [{
          'id' => first_expert.skill.tags.first.id,
          'name' => first_expert.skill.tags.first.name
        }],
        'twitter_link' => first_expert.twitter_link,
        'website_link' => first_expert.website_link
      }, 
      {
        'id' => second_expert.id,
        'email' => second_expert.email,
        'about' => second_expert.about,
        'behance_link' => second_expert.behance_link,
        # 'color' => second_expert.skill.color,
        'github_link' => second_expert.github_link,
        'first_name' => second_expert.first_name,
        'full_name' => second_expert.full_name,
        'job' => second_expert.job,
        'last_name' => second_expert.last_name,
        'linkedin_link' => second_expert.linkedin_link,
        'photo' => second_expert.photo.url(:small),
        'price' => second_expert.price,
        'profile_banner_url' => second_expert.profile_banner.url(:normal),
        'skill_title' => second_expert.skill.title,
        'skill_description' => second_expert.skill.description,
        'slug' => second_expert.slug,
        'stackoverflow_link' => second_expert.stackoverflow_link,
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
        'twitter_link' => second_expert.twitter_link,
        'website_link' => second_expert.website_link
      }
    ])
  end

  context "when sent the category" do
    it "returns only experts with that category" do
      get "/api/v1/experts?category=#{URI.encode(second_expert.skill.tags.last.name)}"

      expect(response_json).to eq([
        {
          'id' => second_expert.id,
          'email' => second_expert.email,
          'about' => second_expert.about,
          'behance_link' => second_expert.behance_link,
          # 'color' => second_expert.skill.color,
          'github_link' => second_expert.github_link,
          'first_name' => second_expert.first_name,
          'full_name' => second_expert.full_name,
          'job' => second_expert.job,
          'last_name' => second_expert.last_name,
          'linkedin_link' => second_expert.linkedin_link,
          'photo' => second_expert.photo.url(:small),
          'price' => second_expert.price,
          'profile_banner_url' => second_expert.profile_banner.url(:normal),
          'skill_title' => second_expert.skill.title,
          'skill_description' => second_expert.skill.description,
          'slug' => second_expert.slug,
          'stackoverflow_link' => second_expert.stackoverflow_link,
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
          'twitter_link' => second_expert.twitter_link,
          'website_link' => second_expert.website_link
        }
      ])
    end
  end

  it 'returns expert' do
    get "/api/v1/experts/#{first_expert.slug}"

    expect(response_json).to eq(
      {
        'id' => first_expert.id,
        'email' => first_expert.email,
        'about' => first_expert.about,
        'behance_link' => first_expert.behance_link,
        # 'color' => first_expert.skill.color,
        'github_link' => first_expert.github_link,
        'first_name' => first_expert.first_name,
        'full_name' => first_expert.full_name,
        'job' => first_expert.job,
        'last_name' => first_expert.last_name,
        'linkedin_link' => first_expert.linkedin_link,
        'photo' => first_expert.photo.url(:small),
        'price' => first_expert.price,
        'profile_banner_url' => first_expert.profile_banner.url(:normal),
        'skill_title' => first_expert.skill.title,
        'skill_description' => first_expert.skill.description,
        'slug' => first_expert.slug,
        'stackoverflow_link' => first_expert.stackoverflow_link,
        'categories' => [],
        'tags' => [{
          'id' => first_expert.skill.tags.first.id,
          'name' => first_expert.skill.tags.first.name,
        }],
        'twitter_link' => first_expert.twitter_link,
        'website_link' => first_expert.website_link
      }
    )
  end
end
