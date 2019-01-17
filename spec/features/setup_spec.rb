require 'spec_helper'

describe 'Setup', type: :feature do
  it 'updates atm state' do
    params = {
      payload: [
        { nominal: 5, number: 7 }
      ]
    }
    put 'api/v1/atm', params
    expect(last_response.status).to eq 201

    get 'api/v1/atm'
    expect(json_response).to match_as_json([{ nominal: 5, number: 7 }])
  end
end
