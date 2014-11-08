json.array! @recent do |conversation|
  interlocutor = ([conversation.older, conversation.newer] - [current_user]).first
  json.id interlocutor.id
  json.full_name interlocutor.full_name
  json.about interlocutor.about
  last_message = conversation.messages.last
  json.text conversation.body
  json.time conversation.updated_at.to_i
  json.unread conversation.messages.unread.count
end
