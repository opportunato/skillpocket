module Messageable
  extend ActiveSupport::Concern

  included do
    acts_as_messageable

    def send_message_to messageable, text
      previous_conversation = mailbox.conversations.participant(messageable).participant(self).first
      if previous_conversation
        reply_to_conversation previous_conversation, text
      else
        send_message messageable, text, '-'
      end
    end

    def conversation_with messageable
      # TODO: check query and simplify
      previous_conversation = mailbox.conversations.participant(messageable).participant(self).first
      if previous_conversation
        previous_conversation.receipts.recipient(self).includes(:message).order(:created_at => :desc)
      else
        []
      end
    end

    def conversations
      mailbox.inbox
    end
  end
end
