class ResultFactory
  def initialize params
    @params = params
  end

  def build
    Result.new params
  end

  private
  def params
    @params.slice(:test_id, :submission_id).merge(status: status)
  end

  def status
    @params[:status].to_i
  end

  class << self
    def build *args
      new(*args).build
    end
  end
end
