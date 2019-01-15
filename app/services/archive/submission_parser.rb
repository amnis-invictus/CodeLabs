class Archive::SubmissionParser
  def initialize xml, zip, user
    @xml, @zip, @user = xml, zip, user
  end

  def attributes
    { user: @user, compiler_id: @xml[:compiler_id], source: source }.compact
  end

  def source
    Archive::FileParser.blob @xml[:source], @zip
  end

  class << self
    def attributes *args
      new(*args).attributes
    end
  end
end
