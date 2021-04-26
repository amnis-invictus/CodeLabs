Recaptcha.configure do |config|
  config.site_key = ENV['RECAPTCHA_SITE_KEY']

  config.secret_key = ENV['RECAPTCHA_SECRET_KEY']

  config.hostname = ENV['RECAPTCHA_HOSTNAME']
end

module Recaptcha::Adapters::ControllerMethods
  def recaptcha_flash_supported?
    true
  end
end
