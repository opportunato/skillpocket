class Conversation < ActiveRecord::Base
  has_many :interlocutors
  has_many :messages
end
