class CreateConversations < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :sender, class: User, null: false
      t.references :recipient, class: User, null: false
      t.references :conversation, null: false
      t.column :is_read, :boolean, default: false
      t.column :body, :text, null: false
      t.column :created_at, :datetime, null: false
    end

    create_table :conversations do |t|
      t.references :older, null: false
      t.references :newer, null: false
    end

    add_foreign_key :messages, :conversations, dependent: :delete
    add_foreign_key :messages, :users, column: :sender_id, dependent: :delete
    add_foreign_key :messages, :users, column: :recipient_id, dependent: :delete
    add_foreign_key :conversations, :users, column: :newer_id, dependent: :delete
    add_foreign_key :conversations, :users, column: :older_id, dependent: :delete

    add_index :conversations, [:older_id, :newer_id], unique: true

    add_index :messages, [:conversation_id, :is_read]
    add_index :messages, [:conversation_id, :created_at]
    add_index :messages, [:conversation_id, :is_read, :created_at]
  end
end
