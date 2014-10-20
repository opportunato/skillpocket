class CreateConversations < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :sender_id, class: User
      t.references :recipient, class: User
      t.references :conversation
      t.column :is_read, :boolean, default: false
      t.column :body, :text, null: false
      t.column :created_at, :datetime, null: false
    end

    create_table :conversations do |t|
    end

    create_table :interlocutors do |t|
      t.references :participant, class: User
      t.references :conversation
    end

    # add_foreign_key :conversations, :users, column: :participant_id, dependent: :delete
    # add_foreign_key :messages, :conversations, dependent: :delete

    # add_index :interlocutors, :participant_id
    # add_index :interlocutors, [:participant_id, :conversation_id]
    # add_index :messages, [:conversation_id, :is_read]
    # add_index :messages, [:conversation_id, :is_read, :created_at]
  end
end
