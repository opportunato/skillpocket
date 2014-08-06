require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'csv'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Skillpocket
  class Application < Rails::Application
    config.assets.paths << "#{Rails.root}/app/assets/fonts"

    config.assets.precompile += %w(admin.js admin.css prelaunch.js)
  end
end
