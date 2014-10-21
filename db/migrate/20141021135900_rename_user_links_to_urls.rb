class RenameUserLinksToUrls < ActiveRecord::Migration
  def change
    rename_column :users, :links, :urls
  end
end
