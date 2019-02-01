class Release
  def initialize submission, params
    @submission = submission

    @test_result = params[:test_result]
  end

  def save
    return false unless @submission.release

    return false unless @submission.update test_result: @test_result, score: score, max_score: max_score

    StandingRedisStore.update_if_exists @submission.user_id, @submission.problem_id, score

    true
  end

  private

  def score
    return unless @test_result == 0

    @submission.results.joins(:test).where(status: :ok).sum('tests.point')
  end

  def max_score
    Test.unscoped.where(problem_id: @submission.problem_id).sum(:point)
  end
end
