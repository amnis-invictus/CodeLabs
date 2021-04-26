class Archive::TranslationParser
  def initialize xml, problem_id
    @xml, @problem_id = xml, problem_id
  end

  def attributes
    {
      id: id,
      _destroy: @xml[:_destroy],
      default: @xml[:default],
      language: @xml[:language],
      caption: @xml[:caption],
      author: @xml[:author],
      text: text,
      technical_text: technical_text,
    }.compact
  end

  private

  def id
    return nil if @problem_id.blank? || @xml[:language].blank?

    ProblemTranslation.select(:id).find_by(problem_id: @problem_id, language: @xml[:language])&.id
  end

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
