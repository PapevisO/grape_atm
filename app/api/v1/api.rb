require_relative 'info'
require_relative 'setup'
require_relative 'withdraw'

module ATM
  class API < Grape::API
    prefix 'api/v1' # Break RESTfullness, simplify usage

    format :json

    # Simple endpoint to get the current status of our API.
    get :is_alive do
      status 201
    end

    mount ::ATM::Info
    mount ::ATM::Setup
    mount ::ATM::Withdraw
  end
end

Application = Rack::Builder.new do
  map '/' do
    run ATM::API
  end
end
