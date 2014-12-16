class ExpertSerializer < ActiveModel::Serializer

  attributes  :id, :full_name, :job, :price, :skill_title
  attributes  :photo_url, :profile_banner_url
  
  alias_method :expert, :object

  def path
    user_path("@#{expert.twitter_handle}")
  end

  def price
    "#{expert.price}$/hr"
  end
end
