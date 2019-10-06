Rails.application.configure do
  config.action_mailer.raise_delivery_errors = true

  config.action_mailer.default_url_options = { host: ENV['APPLICATION_URL'] }

  config.action_mailer.smtp_settings = {
    address: ENV['SMTP_ADDRESS'],
    port: ENV['SMTP_PORT'],
    user_name: ENV['SMTP_USER_NAME'],
    password: ENV['SMTP_PASSWORD'],
    authentication: :plain
  }
end
