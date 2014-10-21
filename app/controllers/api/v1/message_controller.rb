class Api::V1::MessageController < ApiController

  def show
    interlocutor = User.find params[:id]
    @messages = current_user.conversation_with interlocutor
  end

  def create
    recipient = User.find params[:id]
    current_user.send_message_to recipient, params[:text]
    render status: 201, nothing: true
  end
end
