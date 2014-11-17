class AddDefaultSocialAuthority < ActiveRecord::Migration
  def up
    change_column :users, :social_authority, :decimal, default: 0
  end

  def down
    change_column :users, :social_authority, :decimal
  end
end
