class AddBerlinConnects < ActiveRecord::Migration
  def change
    create_table :berlin_connects do |t|
      t.integer :expert_id
      t.string :name
      t.string :email
      t.text :topic
    end
  end
end
