ActiveAdmin.register User do
  decorate_with UserDecorator
  scope :all, :default => true
  scope :approved
  scope :unapproved

  # Filterable attributes on the index screen
  filter :twitter_handle
  filter :full_name
  filter :approved
  filter :created_at

  index do
    selectable_column
    column :twitter_handle
    column :full_name
    column :smartphone_os
    column :tags
    column :approved
  end

  csv do
    column :id
    column :job
    column :about
    column :email
    column :created_at
    column :full_name
    column :twitter_handle
    column :approved
    column :role
    column :social_authority
    column :latitude
    column :longitude
    column :smartphone_os
  end

  batch_action :unapprove do |ids|
    User.find(ids).each do |user|
      user.approved = false
      user.save(validate: false)
    end
    redirect_to collection_path, alert: 'The users have been unapproved'
  end

  batch_action :approve do |ids|
    User.find(ids).each do |user|
      user.approve
    end
    redirect_to collection_path, alert: 'The users have been approved'
  end

  controller do
    def find_resource
      User.find_by_slug(params[:id])
    end
  end
end
