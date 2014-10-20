module Messageable
  extend ActiveSupport::Concern

  included do
    def send_message_to messageable, text
      Message.create sender: self, recipient: messageable, body: text
    end

    def conversation_with messageable
      Message.where(sender: [self, messageable]).where(recipient: [self, messageable]).order(created_at: :desc)
    end

    def conversations
      Message.where(recipient: self).group(:sender).unread.count
    end
  end
end
