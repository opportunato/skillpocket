require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rbenv'
require 'mina-stack'

set :app,                 'skillpocket'
set :server_name,         'skillpocket.com www.skillpocket.com'
set :keep_releases,       100
set :default_server,      :production
set :server, ENV['to'] || default_server
invoke :"env:#{server}"

# Allow calling as `mina deploy at=master`
set :branch, ENV['at'] if ENV['at']

set :server_stack,                  %w(
                                      nginx
                                      postgresql
                                      rbenv
                                      puma
                                      imagemagick
                                      memcached
                                      monit
                                      node
                                    )

set :shared_paths,                  %w(
                                      tmp
                                      log
                                      config/puma.rb
                                      config/application.yml
                                      config/database.yml
                                      public/uploads
                                      public/system
                                    )

set :monitored,                     %w(
                                      nginx
                                      postgresql
                                      puma
                                      memcached
                                    )

task :environment do
  invoke :'rbenv:load'
end

desc "Deploys the current version to the server."
task :deploy do
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'

    to :launch do
      invoke :'puma:restart'
    end
  end
end
