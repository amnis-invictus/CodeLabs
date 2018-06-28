# frozen_string_literal: true

threads_count = ENV.fetch 'RAILS_MAX_THREADS', 5

rails_env = ENV.fetch 'RAILS_ENV', 'development'

threads threads_count, threads_count

environment rails_env

if rails_env == 'production'
  bind ENV['SOCKET']

  pidfile ENV['PID']
else
  port ENV.fetch 'PORT', 3000
end
