source 'https://rubygems.org'

gem 'rails', '4.1.7'
gem 'pg'

gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'autoprefixer-rails'
gem 'bourbon'
gem 'normalize-rails'
gem 'jquery-rails'
gem 'sprockets-commonjs', git: 'git@github.com:maccman/sprockets-commonjs.git'
gem 'sprockets-coffee-react'

gem 'active_model_serializers', '= 0.8.1'
gem 'jbuilder', '~> 2.0'

gem 'mini_magick'
gem 'carrierwave'

gem 'has_scope'
gem 'draper'

gem 'friendly_id'
gem 'warden'
gem 'cancancan'
gem 'social_authority', git: 'git://github.com/opportunato/social_authority.git'

gem 'twitter'
gem 'pagescript', git: 'git@github.com:opportunato/pagescript.git'

gem 'omniauth'
gem 'omniauth-twitter'

gem 'puma'
gem 'figaro'
gem 'simple_form', '~> 3.1.0.rc2', github: 'plataformatec/simple_form', branch: 'master'
gem 'email_validator'

gem 'redis'
gem 'redis-objects'

gem 'meta-tags'

gem 'slim'

gem 'foreigner'
gem 'immigrant'

gem 'grocer' # Apple push notifications

gem 'geocoder'

gem 'inherited_resources', '1.4.1'
gem 'activeadmin', github: 'activeadmin'

gem 'sidekiq' # Off-webapp workers for mail
gem 'sidetiq' # Recurring jobs. FIXME: replace with whenever/CRON once we move to capistrano

group :development do
  gem 'mina-stack', github: 'div/mina-stack'
  gem 'mina-sidekiq'

  gem 'spring'

  gem 'yard-restful' # REST API docs # TODO: guard-yard
  gem 'inch' # Documentation metrics # TODO: guard-inch
  # TODO: mina-yard? how do we generate docs? push to repo (yuck!)?
end

group :development, :test do
  gem 'ffaker'
  gem "factory_girl_rails"
  gem "better_errors"
  gem "binding_of_caller"

  gem "pry"
  gem 'pry-remote'
  gem 'pry-nav'
  gem 'letter_opener'
end

group :test do
  gem "rspec-rails"
  gem "database_rewinder"
  gem "shoulda"
  gem 'timecop'
end
