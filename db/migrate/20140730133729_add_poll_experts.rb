class AddPollExperts < ActiveRecord::Migration
  def change
    create_table :poll_experts do |t|
      t.string "email"
      t.string "full_name"
      t.string "job"
      t.string "twitter_link"
      t.string "linkedin_link"
      t.string "site_link"
      t.string "skill_title"
      t.text   "skill_description"
      t.text   "tags"
      t.string "price"
      t.string "image"
      t.string "step"
      t.string "token"
    end

    drop_table :temp_users
  end
end
