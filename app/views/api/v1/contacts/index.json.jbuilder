json.array! @recent do |conversation|
  interlocutor = ([conversation.older, conversation.newer] - [current_user]).first
  json.id interlocutor.id
  json.full_name interlocutor.full_name
  json.photo interlocutor.photo.url(:small)
  last_message = conversation.messages.last
  json.text conversation.body
  json.time conversation.updated_at.to_i
  json.unread conversation.unread_count(current_user)
end
