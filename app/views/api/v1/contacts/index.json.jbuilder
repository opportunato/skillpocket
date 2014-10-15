json.array! @contacts do |contact|
  other = ( contact.participants - [ @current_user ] ).first
  json.id other.id
  json.full_name other.full_name
  json.about other.about
  json.unread contact.messages.unread.count
  json.message contact.messages.first.body
  json.date contact.messages.first.created_at.to_i
end
