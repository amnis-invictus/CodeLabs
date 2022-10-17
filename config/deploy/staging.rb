set :branch, :master

server 'stage.codelabs.site:10016', user: 'arch-user', roles: %i[app web db]
