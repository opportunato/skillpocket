class UserDecorator < ApplicationDecorator
  decorates :user
  delegate_all

  alias_method :user, :model

  def price
    "#{user.price}$/hr"
  end

  def tags
    user.skill_tags.reduce("") do |string, tag|
      string + tag.name
    end
  end

  def urls
    User::URLS.reduce("") do |string, url|
      user.send(url).present? ? string + url : string
    end
  end
end