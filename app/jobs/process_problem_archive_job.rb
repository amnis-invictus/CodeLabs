class ProcessProblemArchiveJob < ApplicationJob
  def perform user, archive_path, channel_id
    @channel_id = channel_id

    log 'Reading the zip file..'

    zip = Zip::File.open archive_path

    xml = Nokogiri::XML zip.get_input_stream 'problem.xml'

    xml.xpath('problems/problem').each do |problem_xml|
      log 'Looking for the problem or creating a new one..'

      problem = Problem.find_or_initialize_by(id: problem_xml[:id]) { |problem| problem.user = user }

      log 'Parsing attributes..'

      problem.assign_attributes Archive::ProblemParser.attributes problem_xml, zip, user

      log problem.save ? 'Saved the problem.' : "Validation errors occured:\n#{ problem.errors.full_messages.to_sentence }"
    end
  rescue StandardError => e
    log "An expection occured: #{ e }.\n\n#{ e.backtrace }"

    raise
  ensure
    zip.close if zip

    FileUtils.remove archive_path

    log 'Done.'
  end

  private

  def log message
    ActionCable.server.broadcast "ProcessProblemArchive:#{ @channel_id }", message
  end
end
