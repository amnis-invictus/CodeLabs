class Archive::ProblemParser
  def initialize xml, zip, user
    @xml, @zip, @user = xml, zip, user
  end

  def attributes
    {
      memory_limit: @xml[:memory_limit],
      time_limit: @xml[:time_limit],
      real_time_limit: @xml[:real_time_limit],
      private: @xml[:private],
      checker_compiler_id: @xml[:checker_compiler_id],
      checker_source: checker_source,
      tag_ids: tag_ids,
      examples_attributes: examples_attributes,
      tests_attributes: tests_attributes,
      translations_attributes: translations_attributes,
      submissions_attributes: submissions_attributes,
    }.compact
  end

  private

  def checker_source
    Archive::FileParser.blob @xml[:checker_source], @zip
  end

  def tag_ids
    return if @xml.xpath('tags').blank?

    @xml.xpath('tags/tag').map { |tag_xml| tag_xml[:id] }.compact
  end

  def examples_attributes
    return if @xml.xpath('examples').blank?

    @xml.xpath('examples/example').map { |example_xml| Archive::ExampleParser.attributes example_xml }
  end

  def tests_attributes
    return if @xml.xpath('tests').blank?

    @xml.xpath('tests/test').map { |test_xml| Archive::TestParser.attributes test_xml, @zip, @xml[:id] }
  end

  def translations_attributes
    return if @xml.xpath('translations').blank?

    @xml.xpath('translations/translation').map do |translation_xml|
      Archive::TranslationParser.attributes translation_xml, @xml[:id]
    end
  end

  def submissions_attributes
    return if @xml.xpath('submissions').blank?

    @xml.xpath('submissions/submission').map do |submission_xml|
      Archive::SubmissionParser.attributes submission_xml, @zip, @user
    end
  end

  class << self
    def attributes *args
      new(*args).attributes
    end
  end
end
