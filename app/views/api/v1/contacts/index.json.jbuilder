json.array! @recent do |message|
  interlocutor = ([message.conversation.older, message.conversation.newer] - [current_user]).first
  json.id interlocutor.id
  json.full_name interlocutor.full_name
  json.about interlocutor.about
  json.text message.body
  json.time message.created_at.to_i
  json.unread message.conversation.messages.unread.count
end
