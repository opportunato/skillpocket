class AddLastTextToConversations < ActiveRecord::Migration
  def change
    add_column :conversations, :body, :string
    add_column :conversations, :updated_at, :datetime
  end
end
