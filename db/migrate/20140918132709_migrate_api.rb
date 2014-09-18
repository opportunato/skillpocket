class MigrateApi < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :job
      t.text :about
      t.string :photo
      t.string :profile_banner
      t.string :email
      t.string :slug
      t.hstore :links, default: {}
      t.string :access_token
      t.string :twitter_id
      t.string :twitter_token
      t.string :twitter_token_secret

      t.timestamps
    end

    add_index :users, :access_token, unique: true
    add_index :users, :slug, unique: true
    add_index :users, :twitter_token, unique: true

    create_table :skills do |t|
      t.text :description, null: false
      t.integer :price, null: false
      t.string :title, null: false
      t.references :user, null: false
      
      t.timestamps
    end

    add_index :skills, :user_id

    create_table :tags do |t|
      t.string :name
      t.boolean :is_category, default: false

      t.timestamps
    end

    create_table :skills_tags do |t|
      t.references :skill, null: false
      t.references :tag, null: false

      t.timestamps
    end

    add_index :skills_tags, :tag_id
    add_index :skills_tags, :skill_id
  end
end
