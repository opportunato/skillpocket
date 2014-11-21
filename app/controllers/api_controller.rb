class ApiController < ActionController::Base
  before_action :authenticate_with_token

private

  helper_method :current_user

  def current_user
    @current_user
  end

  def authenticate_with_token
    @current_user = authenticate_or_request_with_http_token do |token, options|
      User.find_by(access_token: token)
    end
    logger.info "APIuser: #{current_user.twitter_handle}"
  end
end
