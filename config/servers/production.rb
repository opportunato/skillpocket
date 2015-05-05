namespace :env do
  task :production => [:environment] do
    set :domain,              '52.1.177.21'
    set :user,                'opportunato'
    set :deploy_to,           "/home/#{user}/apps/#{app}"
    set :repository,          "git@github.com:opportunato/skillpocket"
    set :nginx_path,          '/etc/nginx'
    set :deploy_server,       'production'                   # just a handy name of the server
    set :rails_env,           'production'
    set :branch,              'master'
    invoke :defaults                                         # load rest of the config
  end
end