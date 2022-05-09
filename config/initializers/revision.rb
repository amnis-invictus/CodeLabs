if Rails.env.production?
  path = ENV.fetch 'REVISION_FILE'
  REVISION = File.readlines(path).last.strip.freeze if File.exist? path
end
