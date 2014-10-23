class Message < ActiveRecord::Base
  default_scope { order(created_at: :desc) }

  belongs_to :conversation
  belongs_to :sender, class: User
  belongs_to :recipient, class: User

  validates_presence_of :body
  validates_presence_of :conversation_id
  validates_presence_of :sender_id
  validates_presence_of :recipient_id

  scope :unread, -> { where(is_read: false) }
end
