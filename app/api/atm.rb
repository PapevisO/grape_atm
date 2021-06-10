module ATM
  class API < Grape::API
    version 'v1', using: :header, vendor: 'PapevisO'

    format :json

    # Simple endpoint to get the current status of our API.
    get :is_alive do
      status 201
    end
  end
end
