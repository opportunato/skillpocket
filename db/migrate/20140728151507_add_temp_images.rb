class AddTempImages < ActiveRecord::Migration
  def change
    create_table :temp_images do |t|
    end

    add_attachment :temp_images, :image
  end
end
