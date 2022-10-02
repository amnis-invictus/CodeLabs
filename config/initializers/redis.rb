redis_connection = Redis.new driver: :hiredis

$redis_standings = Redis::Namespace.new "#{ Rails.env }_standings", redis: redis_connection
