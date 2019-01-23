set :branch, :production

server 'codelabs.site:10014', user: 'user', roles: %i[app web db]
