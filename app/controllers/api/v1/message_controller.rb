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
      conversation = current_user.conversation_with(interlocutor).first
      conversation.mark_as_read_for(current_user) if conversation
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

  # @url /books
  # @action GET
  #
  # View list of all books
  #
  # @optional [Integer] page Page number
  # @optional [Integer] year Filter books by imprint date
  #
  # @response_field [Integer] page Page number
  # @response_field [Integer] total_pages Total number of pages
  # @response_field [Integer] total_books Total number of books
  # @response_field [Array<Book>] books List of books on this page
  #
  def unread
    unread = Message.recipient(current_user).unread.count
    render json: {unread:  unread}, status: 200
  end
end
