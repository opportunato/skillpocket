json.cache! @profile do
  json.id @profile.id
  json.email @profile.email
  json.about @profile.about
  json.full_name @profile.full_name
  json.first_name @profile.first_name
  json.last_name @profile.last_name
  json.job @profile.job
  json.photo_url @profile.photo.url(:small)
  json.profile_banner_url @profile.profile_banner.url(:normal)
  json.slug @profile.slug

  json.website_link @profile.website_link
  json.twitter_link @profile.twitter_link
  json.linkedin_link @profile.linkedin_link
  json.behance_link @profile.behance_link
  json.github_link @profile.github_link
  json.stackoverflow_link @profile.stackoverflow_link

  if @profile.expert?
    json.price @profile.price
    json.skill_title @profile.skill_title
    json.skill_description @profile.skill_description

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
