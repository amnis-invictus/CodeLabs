Rails.application.config.revision = \
  if Rails.env.production? && ENV.key?('REVISION_FILE') && File.exist?(ENV['REVISION_FILE'])
    IO.readlines(ENV['REVISION_FILE']).last.strip
  else
    ''
  end.freeze
