class BerlinConnect < ActiveRecord::Base
  validates_presence_of :expert_id, :name, :email, :topic
end