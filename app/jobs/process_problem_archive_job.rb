class ProcessProblemArchiveJob < ApplicationJob
  def perform user, archive_path, channel_id
    @user = user

    @channel_id = channel_id

    broadcast 'Job has started.'

    broadcast 'Reading zip file..'

    @zip = Zip::File.open archive_path

    @checker = @zip.glob('checker.*').first

    @solutions = @zip.glob 'solutions/*'

    @xml = @zip.glob('problem.xml').first.get_input_stream { |s| Nokogiri::XML s }

    ApplicationRecord.transaction do
      build_problem

      build_translations

      build_examples

      build_tags

      build_tests

      build_submissions
    end
  rescue => e
    broadcast "An expection occured: #{ e }."

    raise
  ensure
    @zip.close if @zip

    FileUtils.remove archive_path

    broadcast 'Done.'
  end

  private
  def build_problem
    broadcast 'Building problem..'

    @checker.get_input_stream do |io|
      @problem = Problem.create! \
        memory_limit: @xml.at_xpath('problem/memory_limit').content,
        time_limit: @xml.at_xpath('problem/time_limit').content,
        # real_time_limit: @xml.at_xpath('problem/real_time_limit').content,
        checker_source: { io: io, filename: File.basename(@checker.name) },
        checker_compiler: find_compiler_by_file(@checker)
    end

    broadcast 'Ok.'
  end

  def build_translations
    broadcast 'Building translations..'

    i = 0

    @xml.xpath('problem/translations/translation').each do |translation|
      i += 1

      ProblemTranslation.create! \
        language: translation.attribute('language').value,
        caption: translation.at_xpath('caption').content,
        author: translation.at_xpath('author').content,
        text: translation.at_xpath('text').content,
        technical_text: translation.at_xpath('technical_text').content,
        problem: @problem
    end

    broadcast "#{ i } ok."
  end

  def build_examples
    broadcast 'Building examples..'

    i = 0

    @xml.xpath('problem/examples/example').each do |example|
      i += 1

      Example.create! \
        input: example.at_xpath('input').content,
        answer: example.at_xpath('answer').content,
        problem: @problem
    end

    broadcast "#{ i } ok."
  end

  def build_tags
    broadcast 'Building tags with translations..'

    i = 0

    @xml.xpath('problem/translations/translation').each do |translation|
      language = TagTranslation.languages[translation.attribute('language').value]

      translation.xpath('tags/tag').each do |tag|
        i += 1

        t = TagTranslation.find_or_create_by!(language: language, name: tag.content) { |t| t.tag = Tag.create! }

        t.tag.problems << @problem

        t.tag.save!
      end
    end

    broadcast "#{ i } ok."
  end

  def build_tests
    broadcast 'Building tests..'

    i = 0

    @xml.xpath('problem/tests/test').each do |xml|
      test = Test.new num: xml.attribute('num').value, problem: @problem

      %w(input answer).each do |name|
        next unless attr = xml.attribute(name)

        next unless file = @zip.glob(attr.value).first

        file.get_input_stream { |io| test.public_send(name).attach(io: io, filename: File.basename(file.name)) }
      end

      i += 1

      broadcast "Saving test #{ test.num }.."

      test.save!
    end

    broadcast "#{ i } ok."
  end

  def build_submissions
    broadcast 'Building submissions..'

    i = 0

    @solutions.each do |solution|
      solution.get_input_stream do |io|
        i += 1

        Submission.create! \
          problem: @problem,
          compiler: find_compiler_by_file(solution),
          user: @user,
          source: { io: io, filename: File.basename(solution.name) }
      end
    end

    broadcast "#{ i } ok."
  end

  EXTENTION_TO_NAME = { '.cpp' => 'g++' }.freeze

  def find_compiler_by_file file
    Compiler.find_by! name: EXTENTION_TO_NAME[File.extname(file.name)]
  end

  def broadcast message
    ActionCable.server.broadcast "ProcessProblemArchive:#{ @channel_id }", message
  end
end
