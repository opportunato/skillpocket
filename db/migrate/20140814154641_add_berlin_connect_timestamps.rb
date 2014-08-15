class AddBerlinConnectTimestamps < ActiveRecord::Migration
  def change
    change_table :berlin_connects do |t|
      t.string "expert_name"
      
      t.timestamps
    end
  end
end
