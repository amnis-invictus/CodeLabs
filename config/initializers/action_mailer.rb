Rails.application.configure do
  config.action_mailer.raise_delivery_errors = true

  config.action_mailer.default_url_options = { host: ENV.fetch('APPLICATION_URL') }

  config.action_mailer.smtp_settings = {
    address: ENV.fetch('SMTP_ADDRESS', nil),
    port: ENV.fetch('SMTP_PORT', nil),
    user_name: ENV.fetch('SMTP_USER_NAME', nil),
    password: ENV.fetch('SMTP_PASSWORD', nil),
    authentication: :login,
    enable_starttls_auto: true,
  }
end
