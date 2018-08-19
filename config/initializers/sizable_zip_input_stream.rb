class Zip::InputStream
  def size
    @size ||= read.size.tap { rewind }
  end
end
