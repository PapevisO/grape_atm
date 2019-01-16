require_relative 'info'
require_relative 'setup'

module ATM
  class API < Grape::API
    prefix 'api/v1' # Break RESTfullness, simplify usage

    format :json

    # Simple endpoint to get the current status of our API.
    get :is_alive do
      { status: 'ok' }
    end

    mount ::ATM::Info
    mount ::ATM::Setup
  end
end

Application = Rack::Builder.new do
  map '/' do
    run ATM::API
  end
end
