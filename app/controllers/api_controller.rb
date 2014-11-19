class ApiController < ActionController::Base
  helper_method :current_user
  before_action :authenticate!

protected

  def authenticate!
    warden.authenticate!(:http_token)
    logger.info "APIuser: #{current_user.twitter_handle}"
    logger.info header.match(/^Token token=\"(.+)\"$/)[1]
  end

  def current_user
    warden.user
  end

private

  def warden
    env['warden']
  end
end
