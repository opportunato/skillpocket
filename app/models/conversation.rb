class Conversation < ActiveRecord::Base
  # TODO: composite_primary_keys gem? on older_id, newer_id?
  belongs_to :older, class: User
  belongs_to :newer, class: User
  has_many :messages

  # Disallow Andy <=> Pete and Pete <=> Andy conversation duplicates
  before_create do
    self.older, self.newer = [self.older, self.newer].sort_by &:id
  end

  def self.find one, another
    older, newer = [one, another].sort_by &:id
    find_by(older: older, newer: newer)
  end
end
