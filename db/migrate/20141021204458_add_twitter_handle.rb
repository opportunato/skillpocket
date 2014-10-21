class AddTwitterHandle < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :twitter_handle
      t.boolean :approved, default: false
    end

    add_index :users, :twitter_handle
  end
end
