set :branch, :master

set :deploy_to, '/home/user/staging'

namespace :deploy do
  after :finishing, 'staging:restart'
end
