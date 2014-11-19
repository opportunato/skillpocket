class EnlargeYourSearchDistance < ActiveRecord::Migration
  def up
    change_column :users, :max_search_distance, :integer, default: 150
  end

  def down
    change_column :users, :max_search_distance, :integer, default: 30
  end
end
