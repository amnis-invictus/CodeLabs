Rails.application.config.revision = \
  if Rails.env.production? && ENV.key?('REVISION_FILE')
    IO.readlines(ENV['REVISION_FILE']).last.strip
  else
    'debug'
  end.freeze
