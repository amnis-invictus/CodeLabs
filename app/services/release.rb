class Release
  def initialize submission, params
    @submission = submission

    @params = params
  end

  def save
    return false unless @submission.release

    @submission.update test_result: test_result, score: score
  end

  private
  def score
    return unless test_result == 0

    (@submission.results.where(status: :ok).count.to_f / @submission.results.count * 100).round(2)
  end

  def test_result
    @params[:test_result].to_i
  end
end