class CreateUserFriendedExpertFollowers < ActiveRecord::Migration
  def change
    create_table :user_friended_expert_followers do |t|
      t.references :user
      t.references :expert
      t.string :twitter_id

      t.timestamps
    end

    add_index :user_friended_expert_followers, :user_id
    add_index :user_friended_expert_followers, :expert_id
  end
end
