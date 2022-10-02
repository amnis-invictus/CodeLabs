Recaptcha.configure do |config|
  config.site_key = ENV.fetch 'RECAPTCHA_SITE_KEY', nil

  config.secret_key = ENV.fetch 'RECAPTCHA_SECRET_KEY', nil

  config.hostname = ENV.fetch 'RECAPTCHA_HOSTNAME', nil
end

module Recaptcha::Adapters::ControllerMethods
  def recaptcha_flash_supported?
    true
  end
end
