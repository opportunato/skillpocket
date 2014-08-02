class PollExpert < ActiveRecord::Base
  mount_uploader :image, PollExpertUploader

  scope :by_step, -> (step) { where(step: step) }
  scope :published, -> { where(expert_created: true) }
  scope :notpublished, -> { where(expert_created: false) }
end