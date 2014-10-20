class Api::V1::ContactsController < ApiController
  before_filter :authenticate

  def index
    @conversations = current_user.conversations
  end
end
