class WebMessage < ActiveRecord::Base
  validates_presence_of :expert_id, :email, :body, :full_name

  belongs_to :user
  belongs_to :expert, class_name: 'User'
end