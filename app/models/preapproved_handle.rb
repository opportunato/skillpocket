class PreapprovedHandle < ActiveRecord::Base
  def self.preapprove(user)
    if handle = find_by(name: user.twitter_handle)
      user.social_authority = handle.social_authority
      user.approve
      user.save(validate: false)
    end
  end
end
