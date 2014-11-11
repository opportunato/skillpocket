class UserFriendedExpert < ActiveRecord::Base
  belongs_to :user
  belongs_to :expert, class_name: 'User'
end