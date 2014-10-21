class JoinFirstAndLastNames < ActiveRecord::Migration
  def up
    change_table :users do |t|
      t.string :full_name
      t.remove :first_name
      t.remove :last_name
    end
  end

  def down
    change_table :users do |t|
      t.remove :full_name
      t.string :first_name, null: false
      t.string :last_name, null: false
    end
  end
end
