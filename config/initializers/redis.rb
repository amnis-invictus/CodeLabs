redis_connection = Redis.new

$redis_standings = Redis::Namespace.new "#{ Rails.env }_standings", redis: redis_connection

$redis_workers = Redis::Namespace.new "#{ Rails.env }_workers", redis: redis_connection
