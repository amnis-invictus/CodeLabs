$redis_standings = ConnectionPool.new do
  Redis::Namespace.new "#{ Rails.env }_standings", redis: Redis.new
end
