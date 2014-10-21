json.array! @conversations do |messageable, count|
  json.id messageable.id
  json.full_name messageable.full_name
  json.about messageable.about
  json.unread count
end
