class AddSmartphoneOs < ActiveRecord::Migration
  def change
    add_column :skills, :smartphone_os, :string
  end
end
