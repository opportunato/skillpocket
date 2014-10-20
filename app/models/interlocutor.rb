class Interlocutor < ActiveRecord::Base
  belongs_to :participant, class: User
  belongs_to :conversation
end
