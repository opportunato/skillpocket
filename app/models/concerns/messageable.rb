module Messageable
  extend ActiveSupport::Concern

  included do
    has_many :conversations

    def send_message_to messageable, text
      conversation = conversation_with(messageable) || create_conversation(messageable)
      Message.create sender: self, recipient: messageable, conversation: conversation, body: text
    end

    def messages_with messageable
      conversation = conversation_with messageable
      conversation ? conversation.messages : []
    end

    def conversation_with messageable
      Conversation.find self, messageable
    end

    def create_conversation messageable
      conversation = Conversation.create older: self, newer: messageable
    end

    def recent
      Message.
        joins(:conversation).
        where('older_id = ? OR newer_id = ?', self.id, self.id).
        includes(:conversation)
    end
  end
end
