json.array! @messages do |message|
  json.message message.body
  json.incoming message.sender == @current_user
  json.read message.is_read || message.sender == @current_user
  json.date message.created_at.to_i
end
