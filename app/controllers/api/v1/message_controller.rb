class Api::V1::MessageController < ApiController
  skip_before_action :authenticate!

  def show
    interlocutor = User.find params[:id]
    @messages = current_user.messages_with interlocutor
  end

  def create
    recipient = User.find params[:id]
    current_user.send_message_to recipient, params[:text]
    render status: 201, nothing: true
  end

  def unread
    unread = Message.where(recipient: current_user).unread.count
    render json: {unread:  unread}, status: 200
  end
end
