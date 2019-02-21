class StandingRedisStore
  def initialize user_id, problem_id, score = nil
    @user_id, @problem_id, @score = user_id, problem_id, score

    @key = "#{ user_id }_#{ problem_id }"
  end

  def get
    $redis_standings.set @key, score_from_database unless $redis_standings.exists @key

    $redis_standings.get @key
  end

  def update_if_exists
    $redis_standings.set @key, @score, xx: true
  end

  private

  def score_from_database
    params = { user_id: @user_id, problem_id: @problem_id, test_state: :done, test_result: :ok }

    Submission.select(:score).order(created_at: :desc).find_by(params)&.score
  end

  class << self
    def get *args
      new(*args).get
    end

    def update_if_exists *args
      new(*args).update_if_exists
    end
  end
end
