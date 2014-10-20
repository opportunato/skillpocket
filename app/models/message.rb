class Message < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :sender, class: User
  belongs_to :recipient, class: User

  validates_presence_of :body

  scope :unread, -> { where(is_read: false) }
end
