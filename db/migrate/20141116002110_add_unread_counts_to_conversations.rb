class AddUnreadCountsToConversations < ActiveRecord::Migration
  def change
    add_column :conversations, :newer_unread_count, :integer, :null => false, :default => 0
    add_column :conversations, :older_unread_count, :integer, :null => false, :default => 0
  end
end
