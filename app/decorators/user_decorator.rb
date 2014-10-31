class UserDecorator < ApplicationDecorator
  decorates :user
  delegate_all

  alias_method :user, :model

  def price
    "#{user.price}$/hr"
  end

  def tags
    user.skill_tags.map do |tag|
      h.content_tag :li, tag.name
    end.join('').html_safe
  end

  def urls
    User::URLS.map do |url|
      if user.send(url).present? 
        h.content_tag :li do
          h.link_to user.send(url), target: "_blank" do
            url_names[url.to_sym]
          end
        end
      end
    end.join('').html_safe
  end

private

  def url_names
    {
      website_url: "Website",
      twitter_url: "Twitter",
      facebook_url: "Facebook",
      linkedin_url: "LinkedIn",
      behance_url: "Behance",
      github_url: "Github",
      stackoverflow_url: "Stack Overflow"
    }
  end
end
