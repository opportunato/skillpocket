class Api::V1::ContactsController < ApiController
  def index
    @conversations = current_user.conversations
  end
end
