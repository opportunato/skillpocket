class SwitchTwitterIdsToInteger < ActiveRecord::Migration
  def up
    change_column :user_friended_expert_followers, :twitter_id, 'integer USING CAST(twitter_id AS integer)'
  
    add_index :user_friended_expert_followers, :twitter_id
  end

  def down
    change_column :user_friended_expert_followers, :twitter_id, :string

    remove_index :user_friended_expert_followers, :twitter_id
  end
end
