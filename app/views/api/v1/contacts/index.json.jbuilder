json.array! @conversations do |contact, count|
  json.id contact.id
  json.full_name contact.full_name
  json.about contact.about
  json.unread count
end
