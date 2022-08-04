ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../config/environment', __dir__)
require 'rspec/rails'
require 'pundit/rspec'
require 'aasm/rspec'
require 'capybara/rspec'
require 'database_cleaner/active_record'

Dir[Rails.root.join('spec/support/**/*.rb')].sort.each { |f| require f }

RSpec.configure do |config|
  config.mock_with :rspec

  config.order = :random

  config.use_transactional_fixtures = false

  config.before :suite do
    # Delete line `config.use_transactional_fixtures = true` from rails_helper.rb
    # (or set it to false) to prevent uncommitted transactions being used in
    # JavaScript-dependent specs.

    # During testing, the app-under-test that the browser driver connects to
    # uses a different database connection to the database connection used by
    # the spec. The app's database connection would not be able to access
    # uncommitted transaction data setup over the spec's database connection.

    DatabaseCleaner.clean_with :truncation
  end

  config.before :each do
    DatabaseCleaner.strategy = :transaction
  end

  config.before :each, type: :feature do
    # :rack_test driver's Rack app under test shares database connection
    # with the specs, so continue to use transaction strategy for speed.
    driver_shares_db_connection_with_specs = Capybara.current_driver == :rack_test

    unless driver_shares_db_connection_with_specs
      # Driver is probably for an external browser with an app
      # under test that does *not* share a database connection with the
      # specs, so use truncation strategy.
      DatabaseCleaner.strategy = :truncation
    end
  end

  config.before :each do
    DatabaseCleaner.start
  end

  config.append_after :each do
    DatabaseCleaner.clean
  end

  config.fixture_path = Rails.root.join 'spec/fixtures'

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include ActionControllerParameters

  config.include ActiveSupport::Testing::TimeHelpers

  %i[controller view request].each do |type|
    config.include Rails::Controller::Testing::TestProcess, type: type

    config.include Rails::Controller::Testing::TemplateAssertions, type: type

    config.include Rails::Controller::Testing::Integration, type: type
  end

  config.include FactoryBot::Syntax::Methods
  config.include FormHelpers

  config.before { freeze_time }
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec

    with.library :rails
  end
end

browser = ENV['UI_TEST_ENGINE']&.downcase == 'chrome' ? :chrome : :firefox
driver = 'selenium'
driver = "#{ driver }_chrome" if browser == :chrome
driver = "#{ driver }_headless" if ENV.fetch('UI_TEST_HEADLESS') { ENV.fetch('CI', nil) }

Capybara.default_driver = driver.to_sym
Capybara.server = :puma, { Silent: true } if ENV['UI_TEST_SILENT_PUMA']

if ENV['SELENIUM_CUSTOM_URL']
  Capybara.register_driver driver.to_sym do |app|
    Capybara::Selenium::Driver.new app, browser: browser, url: ENV.fetch('SELENIUM_CUSTOM_URL')
  end
end

ActiveRecord::Migration.maintain_test_schema!

I18n.default_locale = :en
