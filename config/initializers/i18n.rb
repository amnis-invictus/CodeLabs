Rails.application.configure do
  config.i18n.available_locales = %i(ru en)

  config.i18n.default_locale = :ru

  config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
end
