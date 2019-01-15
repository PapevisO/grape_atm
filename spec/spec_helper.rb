ENV['RACK_ENV'] = 'test'

require 'rack/test'
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

  config.include RSpecHelpers::JsonHelpers, type: :feature
end

def app
  ATM::API
end
