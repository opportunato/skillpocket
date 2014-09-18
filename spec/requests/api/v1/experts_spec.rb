require 'rails_helper'

RSpec.describe 'GET /v1/experts' do
  it 'returns experts' do
    first_expert = create(:user)
    first_skill = create(:skill, expert: first_expert)

    first_tag = create(:tag)

    first_skill.tags.push first_tag
    first_skill.save!

    second_expert = create(:user)
    second_skill = create(:skill, expert: second_expert)

    second_tag = create(:tag)
    third_tag = create(:tag, is_category: true)

    second_skill.tags.push second_tag, third_tag
    second_skill.save!

    get "/api/v1/experts/"

    expect(response_json).to eq([
      {
        'about' => first_expert.about,
        'behance_link' => first_expert.behance_link,
        'color' => first_skill.color,
        'email' => first_expert.email,
        'github_link' => first_expert.github_link,
        'first_name' => first_expert.first_name,
        'full_name' => first_expert.full_name,
        'id' => first_expert.id,
        'job' => first_expert.job,
        'last_name' => first_expert.last_name,
        'linkedin_link' => first_expert.linkedin_link,
        'photo' => first_expert.photo.url(:small),
        'price' => first_skill.price,
        'skill_title' => first_skill.title,
        'skill_description' => first_skill.description,
        'slug' => first_expert.slug,
        'stackoverflow_link' => first_expert.stackoverflow_link,
        'categories' => [],
        'tags' => [{
          'id' => first_tag.id,
          'name' => first_tag.name
        }],
        'twitter_link' => first_expert.twitter_link,
        'website_link' => first_expert.website_link
      }, 
      {
        'id' => second_expert.id,
        'email' => second_expert.email,
        'about' => second_expert.about,
        'behance_link' => second_expert.behance_link,
        'color' => second_skill.color,
        'github_link' => second_expert.github_link,
        'first_name' => second_expert.first_name,
        'full_name' => second_expert.full_name,
        'job' => second_expert.job,
        'last_name' => second_expert.last_name,
        'linkedin_link' => second_expert.linkedin_link,
        'photo' => second_expert.photo.url(:small),
        'price' => second_skill.price,
        'skill_title' => second_skill.title,
        'skill_description' => second_skill.description,
        'slug' => second_expert.slug,
        'stackoverflow_link' => second_expert.stackoverflow_link,
        'categories' => [{
          'id' => third_tag.id,
          'name' => third_tag.name
        }],
        'tags' => [{
          'id' => second_tag.id,
          'name' => second_tag.name
        }, {
          'id' => third_tag.id,
          'name' => third_tag.name
        }],
        'twitter_link' => second_expert.twitter_link,
        'website_link' => second_expert.website_link
      }
    ])
  end

  context "when sent the category" do
    it "returns only experts with that category" do
      first_expert = create(:user)
      first_skill = create(:skill, expert: first_expert)

      first_tag = create(:tag)

      first_skill.tags.push first_tag
      first_skill.save!

      second_expert = create(:user)
      second_skill = create(:skill, expert: second_expert)

      second_tag = create(:tag, is_category: true)
      third_tag = create(:tag)

      second_skill.tags.push second_tag, third_tag
      second_skill.save!

      get "/api/v1/experts?category=#{URI.encode(second_tag.name)}"

      expect(response_json).to eq([
        {
          'id' => second_expert.id,
          'email' => second_expert.email,
          'about' => second_expert.about,
          'behance_link' => second_expert.behance_link,
          'color' => second_skill.color,
          'github_link' => second_expert.github_link,
          'first_name' => second_expert.first_name,
          'full_name' => second_expert.full_name,
          'job' => second_expert.job,
          'last_name' => second_expert.last_name,
          'linkedin_link' => second_expert.linkedin_link,
          'photo' => second_expert.photo.url(:small),
          'price' => second_skill.price,
          'skill_title' => second_skill.title,
          'skill_description' => second_skill.description,
          'slug' => second_expert.slug,
          'stackoverflow_link' => second_expert.stackoverflow_link,
          'categories' => [{
            'id' => second_tag.id,
            'name' => second_tag.name
          }],
          'tags' => [{
            'id' => second_tag.id,
            'name' => second_tag.name,
          }, {
            'id' => third_tag.id,
            'name' => third_tag.name,
          }],
          'twitter_link' => second_expert.twitter_link,
          'website_link' => second_expert.website_link
        }
      ])
    end
  end
end

RSpec.describe 'GET /v1/experts/:id' do
  it 'returns expert' do
    first_expert = create(:user)
    first_skill = create(:skill, expert: first_expert)

    first_tag = create(:tag)

    first_skill.tags.push first_tag
    first_skill.save!

    get "/api/v1/experts/#{first_expert.slug}"

    expect(response_json).to eq(
      {
        'id' => first_expert.id,
        'email' => first_expert.email,
        'about' => first_expert.about,
        'behance_link' => first_expert.behance_link,
        'color' => first_skill.color,
        'github_link' => first_expert.github_link,
        'first_name' => first_expert.first_name,
        'full_name' => first_expert.full_name,
        'job' => first_expert.job,
        'last_name' => first_expert.last_name,
        'linkedin_link' => first_expert.linkedin_link,
        'photo' => first_expert.photo.url(:small),
        'price' => first_skill.price,
        'skill_title' => first_skill.title,
        'skill_description' => first_skill.description,
        'slug' => first_expert.slug,
        'stackoverflow_link' => first_expert.stackoverflow_link,
        'categories' => [],
        'tags' => [{
          'id' => first_tag.id,
          'name' => first_tag.name,
        }],
        'twitter_link' => first_expert.twitter_link,
        'website_link' => first_expert.website_link
      }
    )
  end
end