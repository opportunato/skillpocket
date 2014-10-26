class AppleNotificationPusher
  def self.push device_token, text
    pusher.push Grocer::Notification.new(
        device_token: device_token,
        alert:        text
      )
  end

protected
  def self.pusher
    @@pusher ||= Grocer.pusher(
      certificate: File.join(Rails.root, 'config', 'push.pem'),
      # passphrase:  "",
      retries:     3   # optional
    )
  end
end
