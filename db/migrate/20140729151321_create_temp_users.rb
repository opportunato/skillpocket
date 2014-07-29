class CreateTempUsers < ActiveRecord::Migration
  def change
    create_table :temp_users do |t|
      t.string :email
      t.string :token
    end

    add_index :temp_users, :token
  end
end
