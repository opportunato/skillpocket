class UnauthorizedController < ActionController::Metal
  include ActionController::UrlFor
  include ActionController::Redirecting
  include Rails.application.routes.url_helpers
  include Rails.application.routes.mounted_helpers

  delegate :flash, to: :request

  def self.call(env)
    @respond ||= action(:respond)
    @respond.call(env)
  end

  def respond
    unless request.get?
      message = env['warden.options'].fetch(:message, "unauthorized.user")
      flash.alert = I18n.t(message)
    end

    if env['warden.options'][:scope] == :admin
      redirect_to admin_login_path
    else
      redirect_to :root
    end
  end
end