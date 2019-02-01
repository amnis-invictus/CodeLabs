redis_connection = Redis.new

$redis_standings = Redis::Namespace.new "#{ Rails.env }_standings", redis: redis_connection
