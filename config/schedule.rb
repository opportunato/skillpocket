# encoding: utf-8

require 'whenever'

env :PATH, ENV['PATH']
set :output, File.expand_path('../../shared/log/crontab.log')
job_type :sidekiq,  "cd :path && RAILS_ENV=:environment bundle exec sidekiq-client :task :output"

every 1.day, at: Time.zone.parse('5am').utc do
  sidekiq 'push TwitterFriendsSyncer'
end