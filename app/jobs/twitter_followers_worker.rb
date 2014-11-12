class TwitterFollowersWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  # https://github.com/tobiassvn/sidetiq/wiki/Known-Issues#ice_cube
  recurrence { hourly.minute_of_hour(0, 20, 40) }

  def perform
    logger.info 'blah'
  end
end
