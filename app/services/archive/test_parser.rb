class Archive::TestParser
  def initialize xml, zip
    @xml, @zip = xml, zip
  end

  def attributes
    { id: @xml[:id], _destroy: @xml[:_destroy], num: @xml[:num], point: @xml[:point], input: input, answer: answer }.compact
  end

  private

  def input
    Archive::FileParser.blob @xml[:input], @zip
  end

  def answer
    Archive::FileParser.blob @xml[:answer], @zip
  end

  class << self
    def attributes *args
      new(*args).attributes
    end
  end
end
