class AddUserFriendedExperts < ActiveRecord::Migration
  def change
    create_table :user_friended_experts do |t|
      t.references :user
      t.references :expert

      t.timestamps
    end

    add_index :user_friended_experts, :user_id
    add_index :user_friended_experts, :expert_id
  end
end
