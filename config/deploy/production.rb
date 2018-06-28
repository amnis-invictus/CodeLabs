set :branch, :production

set :deploy_to, '/home/user/production'

namespace :deploy do
  after :finishing, 'production:restart'
end
