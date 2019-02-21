lock "~> 3.11.0"

set :application, 'CodeLabs'

set :repo_url, 'git@gitlab.com:kostyanf14/CodeLabs.git'

set :rails_env, :production

set :default_env, { path: "$HOME/.rubies/current/bin:$PATH" }

append :linked_files, '.env', 'config/master.key'

append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system', 'storage'

set :deploy_to, '/home/user/application'

namespace :deploy do
  after :finishing, 'application:restart'
  after :finishing, 'nginx:reload'
  after :finishing, 'bundler:clean'
end
