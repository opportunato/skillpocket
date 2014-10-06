json.message receipt.message.body
json.incoming receipt.message.sender == @current_user
json.read receipt.is_read
json.date receipt.created_at.to_i
