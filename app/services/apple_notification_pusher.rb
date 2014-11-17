class AppleNotificationPusher
  def self.push ios_device_token, text, identifier, badge
    return unless ios_device_token
    pusher.push Grocer::Notification.new(
      device_token: ios_device_token,
      alert:        text,
      identifier:   identifier,
      custom:       { 'user-id' => identifier },
      badge:        badge
    )
  end

  def self.badge ios_device_token, badge
    return unless ios_device_token
    pusher.push Grocer::Notification.new(
      device_token: ios_device_token,
      badge:        badge
    )
  end

protected
# TODO: Apple insists on reusing the connection. We may want to save on cert parsing too, so probably it's better to enqueue this and send once in a while (1 sec or so) with ActiveJob
  def self.pusher
    @@pusher ||= Grocer.pusher(
      certificate: File.join(Rails.root, 'config', 'push.pem'),
      # passphrase:  "",
      retries:     3   # optional
    )
  end
end
