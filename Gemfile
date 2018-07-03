source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'rails', '~> 5.2.0'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'mini_racer', platforms: :ruby
gem 'turbolinks', '~> 5'
gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'dotenv-rails'
gem 'pg'
gem 'email_validator'
gem 'kaminari'
gem 'russian'
gem 'simple_form'
gem 'pundit'
gem 'jquery-rails'
gem 'mini_magick'
gem 'toastr-rails'
gem 'hiredis'
gem 'redis', '~> 4.0', require: %w(redis redis/connection/hiredis)
gem 'draper'

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'i18n-debug'
  gem 'capistrano', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-rbenv', require: false
end

group :test do
  gem 'shoulda-matchers'
  gem 'shoulda-callback-matchers'
  gem 'rspec-its'
  gem 'rspec-activemodel-mocks'
  gem 'rails-controller-testing'
end
