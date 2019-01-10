require 'grape'

module ATM
  class API < Grape::API
    prefix 'api/v1' # Break RESTfullness, simplify usage

    format :json

    # Simple endpoint to get the current status of our API.
    get :status do
      { status: 'ok' }
    end
  end
end

Application = Rack::Builder.new do
  map '/' do
    run ATM::API
  end
end
