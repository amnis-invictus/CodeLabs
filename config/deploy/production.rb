set :branch, :production

server 'codelabs.site:10014', user: 'arch-user', roles: %i[app web db]
