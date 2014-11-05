class AddDistancePreferenceToUsers < ActiveRecord::Migration
  def change
    add_column :users, :max_search_distance, :integer, default: 48
  end
end
