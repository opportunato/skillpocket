class AddDataToExperts < ActiveRecord::Migration
  def change
    change_table :poll_experts do |t|
      t.string :first_name
      t.string :last_name
      t.boolean :expert_created, default: false
      t.text :about
      t.string :color
    end
  end
end
