class StandingRedisStore
  def initialize user_id, problem_id
    @user_id, @problem_id = user_id, problem_id

    @key = "#{ user_id }_#{ problem_id }"
  end

  def get
    $redis_standings.with do |client|
      client.set @key, score_from_database unless client.exists? @key
      client.get @key
    end
  end

  def update_if_exists
    $redis_standings.with { _1.set @key, score_from_database if _1.exists? @key }
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
