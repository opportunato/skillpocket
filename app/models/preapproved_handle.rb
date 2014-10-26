class PreapprovedHandle < ActiveRecord::Base
  def self.preapprove(user)
    if handle = find_by_handle(user.twitter_handle)
      user.social_authority = handle.social_authority
      user.approve
      user.save(validate: false)
    end
  end

  def self.find_by_handle(handle)
    where("lower(name) = ?", handle.downcase).first
  end
end
