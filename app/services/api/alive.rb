class Api::Alive
  attr_reader :worker, :params

  delegate :disabled?, :ok?, :failed?, :stale?, :stopped?, to: :worker, prefix: true

  def initialize worker, params
    @worker = worker

    @params = params
  end

  def save
    worker.update params.merge alive_at: Time.zone.now
  end
end
