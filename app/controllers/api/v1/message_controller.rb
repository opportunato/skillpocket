# @restful_api 1.0
#
# Messages
#
class Api::V1::MessageController < ApiController
  # @url /books/:id
  # @action GET
  #
  # View a book
  #
  # @required [Integer] id Identifier the book
  #
  # @response [Book] The requested book
  #
  def show
    interlocutor = User.where(id: params[:id]).first
    return render json: [] unless interlocutor
    @messages = current_user.messages_with interlocutor
    render.tap do
      # Render first. Mark as read afterwards
      @messages.recipient(current_user).unread.mark_as_read
    end
  end

  # @url /messages
  # @action POST
  #
  # Create new book
  #
  # @required [Integer] author_id Identifier of an author
  # @required [String] title Title of the book
  # @optional [Integer] year Imprint year
  # @optional [String] genre Genre of the story
  #
  # @response [Book] The created book
  #
  # @example_request_description Let's try to create a book
  # @example_request
  #   ```json
  #   {
  #     "author_id": 1,
  #     "title": "My first book",
  #     "year": 1999
  #   }
  #   ```
  # @example_response_description The book should be created correctly
  # @example_response
  #   ```json
  #   {
  #     "author": {
  #       "name": "Petr Petrov",
  #       "birthdate": "1968-03-25"
  #     },
  #     "title": "My first book",
  #     "year": 1999,
  #     "genre": ""
  #   }
  #   ```
  def create
    recipient = User.find params[:id]
    current_user.send_message_to recipient, params[:text]
    render json: '', status: 201
  end
end
