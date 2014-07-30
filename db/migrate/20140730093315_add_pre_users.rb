class AddPreUsers < ActiveRecord::Migration
  def change
    create_table :pre_users do |t|
      t.string :email
      t.boolean :is_read, default: false

      t.timestamps
    end
  end
end
