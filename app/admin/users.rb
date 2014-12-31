ActiveAdmin.register User do
  decorate_with UserDecorator
  scope :all, :default => true
  scope :approved
  scope :unapproved
  scope :featured
  scope :not_featured

  permit_params :id, :is_featured, 
    :dribble_url, :angellist_url,
    skill_attributes: [:id, :category]

  # Filterable attributes on the index screen
  filter :twitter_handle
  filter :full_name
  filter :approved
  filter :is_featured
  filter :created_at

  index do
    selectable_column
    column :twitter_handle
    column :full_name
    column :smartphone_os
    column :category
    column :tags
    column :approved
    column :is_featured
    actions
  end

  csv do
    column :id
    column :job
    column :about
    column :email
    column :category
    column :created_at
    column :full_name
    column :twitter_handle
    column :approved
    column :role
    column :social_authority
    column :latitude
    column :longitude
    column :smartphone_os
    column :price
  end

  form do |f|
    f.inputs 'Category', for: [:skill, f.object.skill || Skill.new] do |s|
      s.input :category, as: :radio, collection: Skill::NEW_CATEGORIES
    end
    f.inputs 'Featuring' do
      f.input :is_featured
      f.input :angellist_url
      f.input :dribble_url
    end
    f.actions
  end

  show do
    attributes_table do
      row :photo do 
        image_tag(user.photo_url(:small))
      end
      row :full_name
      row :twitter_handle
      row :email
      row :job
      row :about

      row(:approved) { status_tag(user.approved.to_s) }
      row(:is_featured) { status_tag(user.is_featured.to_s) }

      row :skill_title
      row :category
      row :price
      row :skill_tags_text
      row :social_authority
      row :smartphone_os

      row :website_url do
        link_to(user.website_url, user.website_url, target: "_blank") 
      end
      row :twitter_url do
        link_to(user.twitter_url, user.twitter_url, target: "_blank")
      end
      row :facebook_url do
        link_to(user.facebook_url, user.facebook_url, target: "_blank")
      end
      row :linkedin_url do
        link_to(user.linkedin_url, user.linkedin_url, target: "_blank")
      end
      row :dribble_url do
        link_to(user.dribble_url, user.dribble_url, target: "_blank")
      end
      row :angellist_url do
        link_to(user.angellist_url, user.angellist_url, target: "_blank")
      end
      row :behance_url do
        link_to(user.behance_url, user.behance_url, target: "_blank")
      end
      row :github_url do
        link_to(user.github_url, user.github_url, target: "_blank")
      end
      row :stackoverflow_url do
        link_to(user.stackoverflow_url, user.stackoverflow_url, target: "_blank")
      end
    end
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
