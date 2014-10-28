namespace :env do
  task :staging => [:environment] do
    set :domain,              'staging.skillpocket.com'
    set :user,                'deploy'
    set :deploy_to,           "/home/#{user}/apps/#{app}"
    set :repository,          "git@github.com:opportunato/skillpocket"
    set :nginx_path,          '/etc/nginx'
    set :deploy_server,       'staging'                   # just a handy name of the server
    set :rails_env,           'staging'
    set :branch,              'master'
    invoke :defaults                                         # load rest of the config
  end
end