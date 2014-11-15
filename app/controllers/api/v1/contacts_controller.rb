class Api::V1::ContactsController < ApiController
  def index
    @recent = current_user.recent
  end
end
