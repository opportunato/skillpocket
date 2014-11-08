class Api::V1::ContactsController < ApiController
  def index
    # FIXME: this is AWFUL! 2*25 + 1 queries (last 25 conversations + unreads for each recipient + text of last message)
    @recent = current_user.recent
  end
end
