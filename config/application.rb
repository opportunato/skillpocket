require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'csv'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Skillpocket
  class Application < Rails::Application
    config.assets.paths << "#{Rails.root}/app/assets/fonts"
    config.assets.precompile += %w()
    config.autoload_paths += %W(#{config.root}/lib/helpers)

    config.middleware.insert_after ActionDispatch::Flash, Warden::Manager do |manager|
      manager.default_strategies :api_token
      manager.scope_defaults :user, strategies: [:api_token]
      manager.scope_defaults :admin, strategies: [:password]

      manager.failure_app = UnauthorizedController
    end
  end
end
