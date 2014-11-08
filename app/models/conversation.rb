class Conversation < ActiveRecord::Base
  # TODO: composite_primary_keys gem? on older_id, newer_id?
  belongs_to :older, class: User
  belongs_to :newer, class: User
  has_many :messages

  default_scope { order(updated_at: :desc) }

  scope :participant, -> (participant) { where('older_id = ? OR newer_id = ?', participant.id, participant.id) }

  # Disallow Andy <=> Pete and Pete <=> Andy conversation duplicates
  before_create do
    self.older, self.newer = [self.older, self.newer].sort_by &:id
  end
end
