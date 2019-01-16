ENV['RACK_ENV'] = 'test'

require 'rack/test'
require 'shoulda/matchers'
require 'database_cleaner'
require_relative '../app/api/v1/api'
require_relative '../config/application'
Dir[File.dirname(__FILE__) + '/support/**/*.rb'].each { |f| require f }

include Rack::Test::Methods

RSpec.configure do |config|
  config.mock_with :rspec
  config.expect_with :rspec
  config.color_mode = true
  config.formatter = :documentation
  config.order = 'random'
  config.include(Shoulda::Matchers::ActiveModel, type: :model)
  config.include(Shoulda::Matchers::ActiveRecord, type: :model)

  config.include RSpecHelpers::JsonHelpers, type: :feature

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end

def app
  ATM::API
end
