module Messageable
  extend ActiveSupport::Concern

  included do
    has_many :conversations

    def send_message_to messageable, text
      conversation = conversation_with(messageable).first_or_create(older: self, newer: messageable)
      Message.create sender: self, recipient: messageable, conversation: conversation, body: text
      # FIXME: we assume that Messageable is a User, and User is a NofificationPushable
      AppleNotificationPusher.push messageable.ios_device_token, "#{self.full_name} has sent you a message", self.id, messages_with(messageable).unread.count
    end

    def messages_with messageable
      Message.where(conversation: conversation_with(messageable))
    end

    def conversation_with messageable
      Conversation.participant(self).participant(messageable)
    end

    def recent
      Message.
        joins(:conversation).
        where('older_id = ? OR newer_id = ?', self.id, self.id). # WTF, why I cannot use scope on a joined model:
        # participant(self).
        includes(:conversation)
    end
  end
end
