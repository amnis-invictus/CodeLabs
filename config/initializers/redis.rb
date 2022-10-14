$redis_standings = ConnectionPool.new do
  Redis::Namespace.new "#{ Rails.env }_standings", redis: Redis.new(driver: :hiredis)
end

$redis_workers = ConnectionPool.new do
  Redis::Namespace.new "#{ Rails.env }_workers", redis: Redis.new(driver: :hiredis)
end
