class ProblemFactory < ApplicationFactory
  def initialize params
    @params = params
  end

  def build
    @params.merge tests_attributes: tests_attributes
  end

  private

  def tests_attributes
    @params[:tests_attributes].each do |_, attribute|
      attribute[:input] = build_file attribute[:input_text] if attribute[:input_text].present?

      attribute[:answer] = build_file attribute[:answer_text] if attribute[:answer_text].present?
    end
  end

  def build_file content
    io = Tempfile.new.tap do |file|
      file.write content.to_s

      file.rewind
    end

    ActiveStorage::Blob.build_after_upload io: io, filename: SecureRandom.uuid
  end
end
