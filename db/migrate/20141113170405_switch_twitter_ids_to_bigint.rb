class SwitchTwitterIdsToBigint < ActiveRecord::Migration
  def up
    change_column :user_friended_expert_followers, :twitter_id, 'bigint USING CAST(twitter_id AS bigint)'
  
    add_index :user_friended_expert_followers, :twitter_id
  end

  def down
    change_column :user_friended_expert_followers, :twitter_id, :string

    remove_index :user_friended_expert_followers, :twitter_id
  end
end
