class CreateWebMessages < ActiveRecord::Migration
  def change
    create_table :web_messages do |t|
      t.references :expert
      t.references :user
      t.string :email
      t.string :full_name
      t.text :body
    end
  end
end
