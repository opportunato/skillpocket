class AddTimepstampsToExperts < ActiveRecord::Migration
  def change
    change_table :poll_experts do |t|
      t.timestamps
    end
  end
end
