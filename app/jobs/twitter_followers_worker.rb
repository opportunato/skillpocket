class TwitterFollowersWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  # https://github.com/tobiassvn/sidetiq/wiki/Known-Issues#ice_cube
  recurrence { hourly }

  def perform
    TwitterFriendsSyncer.new(User.from_twitter).sync
  end
end
