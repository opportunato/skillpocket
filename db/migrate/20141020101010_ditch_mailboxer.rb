class DitchMailboxer < ActiveRecord::Migration
  def change
    remove_foreign_key "mailboxer_receipts", :name => "receipts_on_notification_id"
    remove_foreign_key "mailboxer_notifications", :name => "notifications_on_conversation_id"
    remove_foreign_key "mailboxer_conversation_opt_outs", :name => "mb_opt_outs_on_conversations_id"

    drop_table :mailboxer_conversation_opt_outs
    drop_table :mailboxer_receipts
    drop_table :mailboxer_conversations
    drop_table :mailboxer_notifications

    create_table :messages do |t|
      t.references :recipient, class: User
      t.references :sender, class: User
      t.column :is_read, :boolean, default: false
      t.column :body, :text, null: false
      t.column :created_at, :datetime, null: false
    end

    add_foreign_key :messages, :users, column: :recipient_id, dependent: :delete
    add_foreign_key :messages, :users, column: :sender_id, dependent: :delete

    add_index :messages, :recipient_id
    add_index :messages, [:recipient_id, :is_read]
    add_index :messages, [:recipient_id, :sender_id]
    add_index :messages, [:recipient_id, :sender_id, :is_read]
  end
end
