json.cache! expert do
  json.id expert.id
  json.email expert.email
  json.about expert.about
  json.full_name expert.full_name
  json.first_name expert.first_name
  json.last_name expert.last_name
  json.job expert.job
  json.photo expert.photo.url(:small)
  json.price expert.price
  json.slug expert.slug
  json.skill_title expert.skill_title
  json.skill_description expert.skill_description

  json.website_link expert.website_link
  json.twitter_link expert.twitter_link
  json.linkedin_link expert.linkedin_link
  json.behance_link expert.behance_link
  json.github_link expert.github_link
  json.stackoverflow_link expert.stackoverflow_link

  json.profile_banner_url expert.profile_banner.url(:normal)

  json.categories expert.skill_categories do |category|
    json.id category.id
    json.name category.name
  end

  json.tags expert.skill_tags do |skill_tag|
    json.id skill_tag.id
    json.name skill_tag.name
  end
end
