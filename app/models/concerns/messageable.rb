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
      messages = Message.arel_table
      older = messages.alias

      query = messages.
        join(older, Arel::Nodes::OuterJoin).
          on(messages[:created_at].gt(older[:created_at]), messages[:sender_id].eq(older[:sender_id])).
        join(User.arel_table).
          on(User.arel_table[:id].eq(messages[:sender_id])).
        where(older[:id].eq(nil)).
        where(messages[:recipient_id].eq(self.id)).
        project(Arel.sql('users.first_name, users.last_name, users.id, users.about, messages.*'))

      Message.find_by_sql query.to_sql
    end
  end
end
