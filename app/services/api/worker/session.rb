class Api::Worker::Session
  attr_reader :worker

  delegate :disabled?, :ok?, :failed?, :stale?, :stopped?, to: :worker, prefix: true

  def initialize worker
    @worker = worker
  end

  def save
    worker.update alive_at: Time.zone.now, status: :ok
  end

  def destroy
    worker.update alive_at: Time.zone.now, status: :disabled, task_status: []
  end
end
