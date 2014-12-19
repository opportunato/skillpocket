Rails.application.configure do
  config.cache_classes = false

  config.eager_load = false

  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false
  config.action_mailer.raise_delivery_errors = false
  config.active_support.deprecation = :log
  config.active_record.migration_error = :page_load
  config.assets.debug = true
  config.assets.raise_runtime_errors = true

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: "smtp.mandrillapp.com",
    port: 587,
    authentication: "plain",
    user_name: ENV["MANDRILL_USERNAME"],
    password: ENV["MANDRILL_PASSWORD"],
    enable_starttls_auto: false,
    domain: "skillpocket.dev"
  }
  config.action_mailer.raise_delivery_errors = true
end
