class Api::V1::MessageController < ApiController
  def show
    interlocutor = User.find params[:id]
    @messages = current_user.messages_with interlocutor
    render.tap do
      # Render first. Mark as read afterwards
      @messages.recipient(current_user).unread.mark_as_read
    end
  end

  def create
    recipient = User.find params[:id]
    current_user.send_message_to recipient, params[:text]
    render status: 201, nothing: true
  end

  def unread
    unread = Message.recipient(current_user).unread.count
    render json: {unread:  unread}, status: 200
  end
end
