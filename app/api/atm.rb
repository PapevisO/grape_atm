module ATM
  class API < Grape::API
    version 'v1', using: :header, vendor: 'PapevisO'

    format :json

    # Simple endpoint to get the current status of our API.
    get :is_alive do
      status 201
    end

    mount ::ATM::Info
    mount ::ATM::Setup
    mount ::ATM::Withdraw

    add_swagger_documentation \
      info: {
        title: 'ATM API'
      },
      hide_documentation_path: true,
      mount_path: '/swagger_doc',
      markdown: false,
      api_version: 'v1'
  end
end
