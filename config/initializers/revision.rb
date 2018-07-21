if Rails.env.production? && ENV.key?('REVISION_FILE')
  Rails.application.config.revision = IO.readlines(ENV['REVISION_FILE']).last.strip
end

