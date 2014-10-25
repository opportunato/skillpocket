class AddApprove < ActiveRecord::Migration
  def change
    create_table :preapproved_handles do |t|
      t.string     :name
      t.decimal    :social_authority
    end

    add_index :preapproved_handles, :name

    add_column :users, :social_authority, :decimal
  end
end
