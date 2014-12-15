class AddCategories < ActiveRecord::Migration
  def change
    add_column :skills, :category, :integer 
    add_index :skills, :category
  end
end
