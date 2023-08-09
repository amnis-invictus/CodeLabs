ruby '~> 3.0'
source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{ repo }.git" }

gem 'aasm'
gem 'bcrypt'
gem 'bitmask_attributes'
gem 'bootsnap', require: false
gem 'bootstrap', '~> 4.6'
gem 'bootstrap-select-rails'
gem 'cocoon'
gem 'connection_pool'
gem 'dotenv-rails'
gem 'draper'
gem 'email_validator'
gem 'hiredis'
gem 'image_processing'
gem 'jquery-rails'
gem 'kaminari'
gem 'mini_magick'
gem 'nokogiri'
gem 'pg'
gem 'puma'
gem 'pundit'
gem 'rails', '~> 6.1.7'
gem 'rails-assets-sweetalert2', '11.7.20', source: 'https://rails-assets.org'
gem 'rails-i18n'
gem 'recaptcha'
gem 'redis', '< 5', require: %w[redis redis/connection/hiredis]
gem 'redis-namespace'
gem 'rubyzip', require: 'zip'
gem 'russian'
gem 'sassc-rails'
gem 'simple_form'
gem 'sweet-alert2-rails', github: 'just806me/sweet-alert2-rails'
gem 'terser'
gem 'turbolinks'
gem 'turbolinks_render'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'factory_bot_rails'
  gem 'rspec-rails'
end

group :development do
  gem 'bullet'
  gem 'faker', require: false
  gem 'i18n-tasks'
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen'
end

group :test do
  gem 'brakeman'
  gem 'capybara'
  gem 'database_cleaner-active_record'
  gem 'rails-controller-testing'
  gem 'rspec-activemodel-mocks'
  gem 'rspec-its'
  gem 'selenium-webdriver'
  gem 'shoulda-callback-matchers', github: 'just806me/shoulda-callback-matchers'
  gem 'shoulda-matchers'
end

group :lint do
  gem 'code-scanning-rubocop'
  gem 'rubocop'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
end

group :deploy do
  gem 'bcrypt_pbkdf', require: false
  gem 'capistrano', require: false
  gem 'capistrano-rails', require: false
  gem 'ed25519', require: false
end
