class Archive::TestParser
  def initialize xml, zip, problem_id
    @xml, @zip, @problem_id = xml, zip, problem_id
  end

  def attributes
    { id: id, _destroy: @xml[:_destroy], num: @xml[:num], point: @xml[:point], input: input, answer: answer }.compact
  end

  private

  def id
    return nil if @problem_id.blank? || @xml[:num].blank?

    Test.unscoped.select(:id).find_by(problem_id: @problem_id, num: @xml[:num])&.id
  end

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
