class ApiController < ActionController::Base
  before_action :authenticate_with_token

private

  helper_method :current_user

  def current_user
    @current_user
  end

  def authenticate_with_token
    @current_user = authenticate_or_request_with_http_token do |token, options|
      user = User.find_by(access_token: token)
      logger.info "APIuser: #{user.twitter_handle || token}"
      user
    end
  end
end
