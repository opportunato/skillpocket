class AddFreelanceAdviceToUsers < ActiveRecord::Migration
  def change
    add_column :users, :does_freelance, :boolean, default: false
    add_column :users, :does_advice, :boolean, default: true
  end
end
