class Conversation < ActiveRecord::Base
  # TODO: composite_primary_keys gem? on older_id, newer_id?
  belongs_to :older, class: User
  belongs_to :newer, class: User
  has_many :messages

  def unread_count user
    user.id == older_id ? older_unread_count : newer_unread_count
  end

  default_scope { order(updated_at: :desc) }

  scope :participant, -> (participant) { where('older_id = ? OR newer_id = ?', participant.id, participant.id) }

  # Disallow Andy <=> Pete and Pete <=> Andy conversation duplicates
  before_create do
    self.older, self.newer = [self.older, self.newer].sort_by &:id
  end

  def mark_as_read_for user
    counter = user.id == older_id ? :older_unread_count : :newer_unread_count
    update_attribute counter, 0
    messages.recipient(user).update_all(is_read: true)
    AppleNotificationPusher.badge user.ios_device_token, Message.recipient(user).unread.count
  end
end
