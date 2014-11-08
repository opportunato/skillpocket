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
    column :twitter_handle
    column :full_name
    column :approved
    actions
  end

  controller do
    def find_resource
      User.find_by_slug(params[:id])
    end
  end
end
