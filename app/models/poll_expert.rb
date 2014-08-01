class PollExpert < ActiveRecord::Base
  mount_uploader :image, PollExpertUploader

  scope :by_step, -> (step) { where(step: step) }
end