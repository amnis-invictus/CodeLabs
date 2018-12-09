lock "~> 3.11.0"

set :application, 'CodeLabs'

set :repo_url, 'git@gitlab.com:kostyanf14/CodeLabs.git'

set :rails_env, :production

append :linked_files, '.env', 'config/master.key'

append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system', 'vendor/bundle', 'storage'

set :rbenv_type, :user

set :rbenv_ruby, File.read('.ruby-version').strip

set :deploy_to, '/home/user/application'

namespace :deploy do
  after :finishing, 'application:restart'
  after :finishing, 'nginx:reload'
  after :finishing, 'bundler:clean'
end
