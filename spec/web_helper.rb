require 'webmock/rspec'

def stub_twitter_request(path)
  stub_request(:get, 'https://api.twitter.com' + path)
end