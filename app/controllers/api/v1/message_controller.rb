class Api::V1::MessageController < ApiController
  before_filter :authenticate

  def show
    interlocutor = User.find params[:id]
    @receipts = current_user.conversation_with interlocutor
  end

  def create
    recipient = User.find params[:id]
    current_user.send_message_to recipient, params[:text]
    render status: 201, nothing: true
  end
end
