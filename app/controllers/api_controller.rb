class ApiController < ApplicationController
  skip_before_filter :verify_authenticity_token

protected

  def authenticate
    authenticate_or_request_with_http_token do |token|
      @current_user = User.find_by(access_token: token)
    end
  end

  def current_user
    @current_user
  end
end
