json.cache! @profile do
  json.id @profile.id
  json.email @profile.email
  json.about @profile.about
  json.full_name @profile.full_name
  json.job @profile.job
  json.photo_url @profile.photo.url(:small)
  json.profile_banner_url @profile.profile_banner.url(:normal)
  json.slug @profile.slug

  json.website_url @profile.website_url
  json.twitter_url @profile.twitter_url
  json.linkedin_url @profile.linkedin_url
  json.behance_url @profile.behance_url
  json.github_url @profile.github_url
  json.stackoverflow_url @profile.stackoverflow_url

  if @profile.expert?
    json.price @profile.price
    json.skill_title @profile.skill_title

    json.categories @profile.skill_categories do |category|
      json.id category.id
      json.name category.name
    end

    json.tags @profile.skill_tags do |skill_tag|
      json.id skill_tag.id
      json.name skill_tag.name
    end
  end
end
