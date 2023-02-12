if Rails.env.production?
  path = ENV.fetch 'REVISION_FILE'
  REVISION = File.exist?(path) ? File.readlines(path).last.strip.freeze : ''.freeze
else
  REVISION = "<#{ Rails.env }> revision".freeze
end
