json.cache! expert do
  json.id expert.id
  json.email expert.email
  json.about expert.about
  json.full_name expert.full_name
  json.job expert.job
  json.photo expert.photo.url(:small)
  json.price expert.price
  json.slug expert.slug
  json.skill_title expert.skill_title

  json.website_url expert.website_url
  json.twitter_url expert.twitter_url
  json.linkedin_url expert.linkedin_url
  json.behance_url expert.behance_url
  json.github_url expert.github_url
  json.stackoverflow_url expert.stackoverflow_url

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
