class Archive::FileParser
  class << self
    def blob path, zip
      ActiveStorage::Blob.build_after_upload io: zip.get_input_stream(path), filename: File.basename(path)
    rescue Errno::ENOENT
      nil
    end
  end
end
