class ProcessProblemArchiveJob < ApplicationJob
  def perform archive_path
    Zip::File.open archive_path do |zip|
      @checker = zip.glob('checker.*').first

      @solutions = zip.glob 'solutions/*'

      @tests = zip.glob 'tests/*'

      @xml = zip.glob('problem.xml').first.get_input_stream { |s| Nokogiri::XML s }
    end

    ApplicationRecord.transaction do
      build_problem

      build_translations

      build_examples

      build_tags

      build_tests

      build_submissions
    end
  ensure
    FileUtils.remove archive_path
  end

  private
  def build_problem
    @checker.get_input_stream do |io|
      @problem = Problem.create! \
        memory_limit: @xml.at_xpath('problem/memory_limit').content,
        time_limit: @xml.at_xpath('problem/time_limit').content,
        # real_time_limit: @xml.at_xpath('problem/real_time_limit').content,
        checker_source: { io: io, filename: SecureRandom.uuid },
        checker_compiler: find_compiler_by_file(@checker)
    end
  end

  def build_translations
    @xml.xpath('problem/translations/translation').each do |translation|
      ProblemTranslation.create! \
        language: translation.attribute('language').value,
        caption: translation.at_xpath('caption').content,
        author: translation.at_xpath('author').content,
        text: translation.at_xpath('text').content,
        technical_text: translation.at_xpath('technical_text').content,
        problem: @problem
    end
  end

  def build_examples
    @xml.xpath('problem/examples/example').each do |example|
      Example.create! \
        input: example.at_xpath('input').content,
        answer: example.at_xpath('answer').content,
        problem: @problem
    end
  end

  def build_tags
    @xml.xpath('problem/translations/translation').each do |translation|
      language = TagTranslation.languages[translation.attribute('language').value]

      translation.xpath('tags/tag').each do |tag|
        Tag.joins(:translations).find_or_create_by!(tag_translations: { language: language, name: tag.content }) do |tag|
          tag.problem = @problem
        end
      end
    end
  end

  def build_tests
    Hash.new { |_, num| Test.new num: num, problem: @problem }.tap do |result|
      @tests.each do |test|
        test.get_input_stream do |io|
          num, type = test.name[6..-1].split('_')

          if type == 'input.txt'
            result[num].input = { io: io, filename: SecureRandom.uuid }
          else
            result[num].answer = { io: io, filename: SecureRandom.uuid }
          end
        end
      end
    end.values.tap { |v| v.each &:save! }
  end

  def build_submissions
    @solutions.each do |solution|
      solution.get_input_stream do |io|
        Submission.create! \
          problem: @problem,
          compiler: find_compiler_by_file(solution),
          source: { io: io, filename: SecureRandom.uuid }
      end
    end
  end

  EXTENTION_TO_NAME = { '.cpp' => 'gcc' }.freeze

  def find_compiler_by_file file
    Compiler.find_by! name: EXTENTION_TO_NAME[File.extname(file.name)]
  end
end
