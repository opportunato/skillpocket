class PollExpert < ActiveRecord::Base
  mount_uploader :image, PollExpertUploader
end