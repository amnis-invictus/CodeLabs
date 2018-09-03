class ProcessProblemArchiveJob < ApplicationJob
  def perform user, archive_path, channel_id
    @user = user

    @channel_id = channel_id

    broadcast 'Job has started.'

    broadcast 'Reading zip file..'

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
  rescue => e
    broadcast "An expection occured: #{ e }."

    raise
  ensure
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
  end

  def build_translations
    broadcast 'Building translations..'

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
    broadcast 'Building examples..'

    @xml.xpath('problem/examples/example').each do |example|
      Example.create! \
        input: example.at_xpath('input').content,
        answer: example.at_xpath('answer').content,
        problem: @problem
    end
  end

  def build_tags
    broadcast 'Building tags..'

    @xml.xpath('problem/translations/translation').each do |translation|
      language = TagTranslation.languages[translation.attribute('language').value]

      translation.xpath('tags/tag').each do |tag|
        t = TagTranslation.find_or_create_by!(language: language, name: tag.content) { |t| t.tag = Tag.create! }

        t.tag.problems << @problem
        
        t.tag.save!
      end
    end
  end

  def build_tests
    broadcast 'Building tests..'

    Hash.new { |_, num| Test.new num: num, problem: @problem }.tap do |result|
      @tests.each do |test|
        test.get_input_stream do |io|
          num, type = test.name[6..-1].split('_')

          if type == 'input.txt'
            result[num].input = { io: io, filename: File.basename(test.name) }
          else
            result[num].answer = { io: io, filename: File.basename(test.name) }
          end
        end
      end
    end.values.tap { |v| v.each &:save! }
  end

  def build_submissions
    broadcast 'Building submissions..'

    @solutions.each do |solution|
      solution.get_input_stream do |io|
        Submission.create! \
          problem: @problem,
          compiler: find_compiler_by_file(solution),
          user: @user,
          source: { io: io, filename: File.basename(solution.name) }
      end
    end
  end

  EXTENTION_TO_NAME = { '.cpp' => 'gcc' }.freeze

  def find_compiler_by_file file
    Compiler.find_by! name: EXTENTION_TO_NAME[File.extname(file.name)]
  end

  def broadcast message
    ActionCable.server.broadcast "ProcessProblemArchive:#{ @channel_id }", message
  end
end
