class Archive::TranslationParser
  def initialize xml
    @xml = xml
  end

  def attributes
    {
      id: @xml[:id],
      _destroy: @xml[:_destroy],
      default: @xml[:default],
      language: @xml[:language],
      caption: @xml[:caption],
      author: @xml[:author],
      text: text,
      technical_text: technical_text
    }.compact
  end

  private

  def text
    @xml.at_xpath('text')&.inner_html
  end

  def technical_text
    @xml.at_xpath('technical_text')&.inner_html
  end

  class << self
    def attributes *args
      new(*args).attributes
    end
  end
end
